// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/createClassSchedule.dart';
import 'package:balance/screen/createClass/createClassStep1SelectType.dart';
import 'package:balance/screen/createClass/createClassStep3WhatToExpect.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class CreateClassWhatYouWillNeed extends StatefulWidget {
  const CreateClassWhatYouWillNeed({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassWhatYouWillNeed> createState() =>
      _CreateClassWhatYouWillNeed();
}

class _CreateClassWhatYouWillNeed extends State<CreateClassWhatYouWillNeed> {
  //variables

  @override
  Widget build(BuildContext context) {
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
              editClassWhatYouWillNeed(widget.classTemplate),
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
                  child: LoginFooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: "Continue",
                  ),
                ),
                onTap: () {
                  print(widget.classTemplate.classType
                      .toString()
                      .split('.')
                      .last);
                  switch (widget.classTemplate.classType) {
                    case ClassType.solo:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassCategory(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.group:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassCategory(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.virtual:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassCategory(
                              classTemplate: widget.classTemplate)));
                      break;
                  }
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
            'Let clients know what they’re going to need',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}

Widget editClassWhatYouWillNeed(Class template) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 46.5,
        right: 46.5,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(color: snow),
          child: TextField(
            maxLength: 500,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            autocorrect: true,
            cursorColor: ocean,
            maxLines: null,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 18,
                fontWeight: FontWeight.w600),
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
              template.classUserRequirements = val;
            },
          )),
    ),
  );
}
