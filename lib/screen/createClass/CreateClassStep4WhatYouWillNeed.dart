// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/createClassStep3WhatToExpect.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/ClassModel.dart';
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
  var textController = TextEditingController();

  //----------
  @override
  void initState() {
    super.initState();
    textController.text = classTemplate.classUserRequirements;
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
              style: logInPageTitleH3,
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  Widget editClassWhatYouWillNeed(Class template) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 45,
        ),
        child: Container(
            padding: EdgeInsets.only(top: 25),
            decoration: BoxDecoration(color: snow),
            child: TextField(
              controller: textController,
              maxLength: 500,
              autocorrect: true,
              cursorColor: ocean,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              textInputAction: TextInputAction.newline,
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
                  color: shark60,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (val) {
                template.classUserRequirements = val;
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
                    child: FooterButton(
                      buttonColor: strawberry,
                      textColor: snow,
                      buttonText: "Continue",
                    ),
                  ),
                  onTap: () {
                    switch (widget.classTemplate.classType) {
                      case ClassType.Solo:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateClassCategory(
                                classTemplate: widget.classTemplate)));
                        break;
                      case ClassType.Group:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateClassCategory(
                                classTemplate: widget.classTemplate)));
                        break;
                      case ClassType.Virtual:
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreateClassCategory(
                                classTemplate: widget.classTemplate)));
                        break;
                    }
                  }),
            )),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
