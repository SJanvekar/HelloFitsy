import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/feModels/AuthModel.dart';
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
    double bottomPadding = ((MediaQuery.of(context).size.width) / 2) - 20;
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 0,
          ),
          child: TextButton(
            onPressed: () {
              print("Back");
              Navigator.of(context).pop(CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => PersonalInfo(
                        authTemplate: authTemplate,
                        userTemplate: userTemplate,
                      )));
            },
            child: Text("Back", style: logInPageNavigationButtons),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
              child: Stack(
            children: [
              Container(
                  child: Column(
                children: [
                  ClipOval(
                    child: profilePictureImage != null
                        ? Image.file(
                            profilePictureImage!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/profilePictureDefault.png',
                            height: 200,
                            width: 200,
                            scale: 0.8,
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
            padding: EdgeInsets.only(bottom: 15.0, left: 26.0, right: 26.0),
            child: GestureDetector(
              child: FooterButton(
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
        padding: const EdgeInsets.only(bottom: 55.0, left: 26.0, right: 26.0),
        child: GestureDetector(
          child: FooterButton(
              buttonColor: strawberry, textColor: snow, buttonText: 'Continue'),
          onTap: () => {
            uploadImage(),
            print(userTemplate.profileImageURL),
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategorySelection(
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
