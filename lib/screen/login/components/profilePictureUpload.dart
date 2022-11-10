import 'dart:io';
import 'dart:math';
import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/categorySelection.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../feModels/userModel.dart';

// var image = AssetImage('assets/images/profilePictureDefault.png');
var image;

class ProfilePictureUpload extends StatefulWidget {
  ProfilePictureUpload({Key? key, required this.userTemplate})
      : super(key: key);

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
    double bottomPadding = ((MediaQuery.of(context).size.width) / 2) - 20;
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
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
                  print("Back to Personal Info");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => PersonalInfo()));
                },
                child: Row(
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
                              builder: (context) => PersonalInfo()));
                        },
                        child: Text("Back", style: logInPageNavigationButtons),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
              child: Stack(
            children: [
              Container(
                  height: 155,
                  width: 155,
                  child: Column(
                    children: [
                      ClipOval(
                        child: profilePictureImage != null
                            ? Image.file(
                                profilePictureImage!,
                                width: 155,
                                height: 155,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/profilePictureDefault.png',
                                height: 155,
                                width: 155,
                              ),
                      ),
                    ],
                  )),
            ],
          )),
          pageTitle(),
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: pageText(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: GestureDetector(
              child: LoginFooterButton(
                  buttonColor: ocean,
                  textColor: snow,
                  buttonText: 'Upload Picture'),
              onTap: () => {
                pickImage(ImageSource.gallery),
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 55.0),
        child: GestureDetector(
          child: LoginFooterButton(
              buttonColor: strawberry, textColor: snow, buttonText: 'Continue'),
          onTap: () => {
            uploadImage(),
            print(userTemplate.profileImageURL),
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    CategorySelection(userTemplate: userTemplate)))
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

Widget pageTitle() {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Upload a profile picture',
          style: logInPageTitle,
        )),
  );
}

Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: [
          TextSpan(
            text: 'Connect with trainers on a more personal level ',
          )
        ],
      ),
    ),
  );
}
