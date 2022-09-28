import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/categorySelection.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// var image = AssetImage('assets/images/profilePictureDefault.png');
var image;

class ProfilePictureUpload extends StatefulWidget {
  ProfilePictureUpload({Key? key}) : super(key: key);

  @override
  State<ProfilePictureUpload> createState() => _ProfilePictureUploadState();
}

class _ProfilePictureUploadState extends State<ProfilePictureUpload> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        final image = AssetImage('assets/images/profilePictureDefault.png');
        return;
      }

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 135.0),
            child: Center(
                child: Stack(
              children: [
                Container(
                    height: 155,
                    width: 155,
                    child: Column(
                      children: [
                        ClipOval(
                          child: image != null
                              ? Image.file(
                                  image!,
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
                    ))
              ],
            )),
          ),
          pageTitle(),
          pageText(),
          Padding(
            padding: const EdgeInsets.only(top: 162, bottom: 15),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: GestureDetector(
              child: LoginFooterButton(
                  buttonColor: strawberry,
                  textColor: snow,
                  buttonText: 'Continue'),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategorySelection()))
              },
            ),
          )
        ],
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
        children: const [
          TextSpan(
            text: 'Connect with trainers on a more personal level ',
          )
        ],
      ),
    ),
  );
}
