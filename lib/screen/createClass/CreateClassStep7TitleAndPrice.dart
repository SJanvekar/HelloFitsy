// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/Main.dart';
import 'package:balance/Requests/ClassRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/createClassStep3WhatToExpect.dart';
import 'package:balance/screen/home/Home.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateClassTitleAndPrice extends StatefulWidget {
  const CreateClassTitleAndPrice({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassTitleAndPrice> createState() => _CreateClassTitleAndPrice();
}

Future uploadImage() async {
  if (classTemplate.profileImageTempHolder == null) return;

  try {
    //Storage Reference
    final firebaseStorage = FirebaseStorage.instance.ref();

    //Create a reference to image
    final profilePictureRef =
        firebaseStorage.child(classTemplate.profileImageTempHolder!.path);

    //Upload file. FILE MUST EXIST
    await profilePictureRef.putFile(classTemplate.profileImageTempHolder!);

    final imageURL = await profilePictureRef.getDownloadURL();

    classTemplate.classImageUrl = imageURL;
  } catch (e) {
    print("Error: $e");
  }
}

class _CreateClassTitleAndPrice extends State<CreateClassTitleAndPrice> {
  var titleController = TextEditingController();
  var costController = TextEditingController();
  var locationController = TextEditingController();

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.651070, -79.347015),
    zoom: 12,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  //----------
  @override
  void initState() {
    super.initState();
    titleController.text = widget.classTemplate.className;
    if (widget.classTemplate.classPrice == 0 &&
        widget.classTemplate.className.isNotEmpty) {
      costController.text = widget.classTemplate.classPrice.toString();
    }

    locationController.text = widget.classTemplate.classLocationName;
  }

  Widget ClassTitle(Class template) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is your class called?',
              style: sectionTitlesClassCreation,
            ),
            Container(
                padding: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(color: snow),
                child: TextField(
                  controller: titleController,
                  maxLength: 100,
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  autocorrect: true,
                  cursorColor: ocean,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Start typing here',
                    hintStyle: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: shark60,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (val) {
                    template.className = val;
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget ClassCost(Class template) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How much does your class cost?',
              style: sectionTitlesClassCreation,
            ),
            Container(
                padding: EdgeInsets.only(top: 0),
                decoration: BoxDecoration(color: snow),
                child: TextField(
                  controller: costController,
                  maxLength: 30,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  autocorrect: true,
                  cursorColor: ocean,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    prefix: Text(
                      "\$ ",
                      style: TextStyle(
                          fontFamily: 'SFDisplay',
                          color: jetBlack80,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    border: InputBorder.none,
                    hintText: 'Start typing here',
                    hintStyle: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: shark60,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (val) {
                    if (val == ' ') {
                      var price = double.parse(val);
                      template.classPrice = price;
                    } else {
                      return;
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget ClassLocation(Class template) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Where is your class located?',
              style: sectionTitlesClassCreation,
            ),
            TextField(
              controller: locationController,
              maxLength: 100,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              autocorrect: true,
              cursorColor: ocean,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter an address',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: shark60,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onChanged: (val) {
                var addresses = [];
                addresses.add(locationFromAddress(val));
                print(addresses[0].toString());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: GoogleMap(
                  mapType: MapType.terrain,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //variables
  @override
  Widget build(BuildContext context) {
    void createClass() async {
      //Firebase Image Upload
      await uploadImage();
      final sharedPrefs = await SharedPreferences.getInstance();
      User user =
          User.fromJson(jsonDecode(sharedPrefs.getString('loggedUser') ?? ''));
      widget.classTemplate.classTrainerID = user.userID;
      ClassRequests().addClass(widget.classTemplate).then((val) {
        if (val.data['success']) {
          print('Successful class add');
          Navigator.of(context).push(PageTransition(
              fullscreenDialog: true,
              type: PageTransitionType.topToBottomPop,
              duration: Duration(milliseconds: 250),
              childCurrent: CreateClassTitleAndPrice(
                classTemplate: classTemplate,
              ),
              child: MainPage()));
        } else {
          print("Creating class failed: ${val.data['msg']}");
        }
      });
    }

    return Scaffold(
      backgroundColor: snow,

      //AppBar
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: TextButton(
                onPressed: () {
                  print("Back");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => CreateClassWhatToExpect(
                          classTemplate: classTemplate)));
                },
                child: Text("Back", style: logInPageNavigationButtons),
              ),
            ),
          ],
        ),
      ),

      //Body
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              pageTitle(),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: ClassTitle(widget.classTemplate),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: ClassCost(widget.classTemplate),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: ClassLocation(widget.classTemplate),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
      //Bottom Navigation Bar
      bottomNavigationBar: Container(
          height: 110,
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 14,
              bottom: 46,
            ),
            child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 26.0,
                    right: 26.0,
                  ),
                  child: FooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: "Finish",
                  ),
                ),
                onTap: () {
                  createClass();
                }),
          )),
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 46.5,
        right: 46.5,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(color: snow),
          child: Text(
            "Let’s add some finishing touches",
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
