// ignore_for_file: prefer_const_constructors, file_names

import 'dart:io';

import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePictureUpload extends StatelessWidget {
  const ProfilePictureUpload({Key? key}) : super(key: key);

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
                          print("Cancel");
                          Navigator.of(context).pop(CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => PersonalInfo()));
                        },
                        child:
                            Text("Cancel", style: logInPageNavigationButtons),
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
            padding: const EdgeInsets.only(top: 167.0),
            child: Center(child: profileImage()),
          ),
          pageTitle(),
          pageText(),
          Padding(
            padding: const EdgeInsets.only(top: 162, bottom: 15),
            child: LoginFooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: 'Upload Picture'),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: LoginFooterButton(
                buttonColor: shark, textColor: snow, buttonText: 'Continue'),
          )
        ],
      ),
    );
  }
}

Widget profileImage() {
  return Stack(
    children: const [
      CircleAvatar(
        radius: 65,
        backgroundImage: AssetImage('assets/images/profilePictureDefault.png'),
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
