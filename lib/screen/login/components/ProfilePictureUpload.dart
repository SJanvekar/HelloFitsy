import 'dart:io';
import 'package:balance/Constants.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/login/components/CategorySelection.dart';
import 'package:balance/screen/login/components/TrainerOrTrainee.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../feModels/UserModel.dart';

// var image = AssetImage('assets/images/profilePictureDefault.png');
var image;

class ProfilePictureUpload extends StatefulWidget {
  ProfilePictureUpload(
      {Key? key, required this.authTemplate, required this.userTemplate})
      : super(key: key);

  final Auth authTemplate;
  final User userTemplate;

  @override
  State<ProfilePictureUpload> createState() => _ProfilePictureUploadState();
}

class _ProfilePictureUploadState extends State<ProfilePictureUpload> {
  File? profilePictureImage;

  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      print(image?.path);
      if (image == null) {
        image = XFile('assets/images/profilePictureDefault.png');
        return;
      }

      setState(() {
        if (image != null) {
          profilePictureImage = File(image.path);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future uploadImage() async {
    if (profilePictureImage == null) return;

    try {
      //Storage Reference
      final firebaseStorage = FirebaseStorage.instance.ref();

      //Create a reference to image
      // print(profilePictureImage!.path);
      final profilePictureRef =
          firebaseStorage.child(profilePictureImage!.path);

      //Upload file. FILE MUST EXIST
      await profilePictureRef.putFile(profilePictureImage!);

      final imageURL = await profilePictureRef.getDownloadURL();

      userTemplate.profileImageURL = imageURL;
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
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
                      builder: (context) => TrainerOrTrainee()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 8, left: 15.0, right: 15.0, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(children: [
              pageTitle(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: pageText(),
              ),
            ]),

            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Center(
                  child: GestureDetector(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                        color: snow,
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: 1,
                          color:
                              profilePictureImage != null ? snow : jetBlack40,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        profilePictureImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.58,
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.file(
                                      profilePictureImage!,
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Icon(
                                    FitsyIconsSet1.upload,
                                    size: 30,
                                    color: jetBlack60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Click here to upload',
                                      style: logInPageBodyText,
                                    ),
                                  )
                                ],
                              ),
                      ],
                    )),
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
              )),
            ),
            if (profilePictureImage != null)
              const Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Center(
                  child: Text(
                    'Click your image to change it before continuing',
                    style: logInPageBodyTextNote,
                  ),
                ),
              )
            // Padding(
            //   padding: EdgeInsets.only(bottom: 15.0, left: 26.0, right: 26.0),
            //   child: GestureDetector(
            //     child: FooterButton(
            //         buttonColor: ocean,
            //         textColor: snow,
            //         buttonText: 'Upload Picture'),
            //     onTap: () => {
            //       pickImage(ImageSource.gallery),
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 45.0, left: 15.0, right: 15.0),
        child: GestureDetector(
          child: Hero(
            tag: 'Bottom',
            child: FooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: 'Continue'),
          ),
          onTap: () => {
            uploadImage(),
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => PersonalInfo(
                    authTemplate: authTemplate, userTemplate: userTemplate)))
          },
        ),
      ),
    );
  }
}

Widget profileImage() {
  return Stack(
    children: [
      CircleAvatar(
        radius: 65,
        backgroundImage: image,
        backgroundColor: snow,
      )
    ],
  );
}

//Page title
Widget pageTitle() {
  return Container(
      decoration: BoxDecoration(color: snow),
      child: Text(
        'Give us a smile!',
        style: logInPageTitleH1,
      ));
}

//PageText
Widget pageText() {
  return Text(
    'Upload a profile picture to help your profile stand out ',
    style: logInPageBodyText,
  );
}
