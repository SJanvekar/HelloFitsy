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
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep7ClassLocation.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/createClassStep3WhatToExpect.dart';
import 'package:balance/screen/home/Home.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
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
    print(imageURL);
  } catch (e) {
    print("Error: $e");
  }
}

class _CreateClassTitleAndPrice extends State<CreateClassTitleAndPrice> {
  var titleController = TextEditingController();
  var costController = TextEditingController();
  var locationController = TextEditingController();
  double currentLat = 43.651070;
  double currentLong = -79.347015;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition _kCurrentLocation;

  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    currentLat = position.latitude;
    currentLong = position.longitude;
  }

  // static const CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  //----------
  @override
  void initState() {
    super.initState();

    getCurrentLocation();

    _kCurrentLocation = CameraPosition(
      target: LatLng(currentLat, currentLong),
      zoom: 12,
    );
    titleController.text = widget.classTemplate.className;
    if (widget.classTemplate.classPrice == 0 &&
        widget.classTemplate.className.isNotEmpty) {
      costController.text = widget.classTemplate.classPrice.toString();
    }

    locationController.text = widget.classTemplate.classLocationName;
  }

  Widget ClassTitle(Class template) {
    return Column(
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
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Start typing here',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (val) {
                template.className = val;
              },
            )),
      ],
    );
  }

  Widget ClassCost(Class template) {
    return Column(
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
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
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
                      color: jetBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                border: InputBorder.none,
                hintText: 'Start typing here',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
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
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      FitsyIconsSet1.arrowleft,
                      color: jetBlack60,
                      size: 15,
                    ),
                    const Text(
                      "Back",
                      style: logInPageNavigationButtons,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => SelectClassLocation(
                            classTemplate: classTemplate,
                          )));
                },
              ),
            ],
          ),
        ),
      ),

      //Body
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pageTitle(),
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: ClassTitle(widget.classTemplate),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: ClassCost(widget.classTemplate),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
      //Bottom Navigation Bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          bottom: 55.0,
        ),
        child: GestureDetector(
            child: FooterButton(
              buttonColor: strawberry,
              textColor: snow,
              buttonText: "Finish",
            ),
            onTap: () {
              createClass();
            }),
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: Container(
        decoration: BoxDecoration(color: snow),
        child: Text(
          "Almost done... \nLet’s add some finishing touches",
          style: logInPageTitleH3,
        )),
  );
}
