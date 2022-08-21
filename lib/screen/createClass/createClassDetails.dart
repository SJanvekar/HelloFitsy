// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassPicture.dart';
import 'package:balance/screen/createClass/createClassSchedule.dart';
import 'package:balance/screen/createClass/createClassType.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class CreateClassDetails extends StatefulWidget {
  const CreateClassDetails({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassDetails> createState() => _CreateClassDetails();
}

class _CreateClassDetails extends State<CreateClassDetails> {
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
                      builder: (context) => CreateClassType()));
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pageTitle(),
              editClassTitle(widget.classTemplate),
              editClassPrice(widget.classTemplate),
              editClassDescription(widget.classTemplate),

              //Slider Stuff
              Padding(
                padding: const EdgeInsets.only(top: 36.0, bottom: 45),
                child: GestureDetector(
                    child: LoginFooterButton(
                      buttonColor: strawberry,
                      textColor: snow,
                      buttonText: "Continue",
                    ),
                    onTap: () {
                      print(widget.classTemplate.classType
                          .toString()
                          .split('.')
                          .last);
                      switch (widget.classTemplate.classType) {
                        case ClassType.solo:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateClassPicture(
                                  classTemplate: widget.classTemplate)));
                          break;
                        case ClassType.group:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateClassSchedule(
                                  classTemplate: widget.classTemplate)));
                          break;
                        case ClassType.virtual:
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateClassPicture(
                                  classTemplate: widget.classTemplate)));
                          break;
                      }
                    }),
              ),
            ],
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
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
            'Add a title, price, and description',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}

Widget editClassTitle(Class template) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 88,
        right: 88,
        bottom: 5,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(color: snow),
          child: TextField(
            autocorrect: true,
            cursorColor: ocean,
            maxLines: null,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 24,
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: shark60, width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2)),
              hintText: 'Class Title',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: (val) {
              template.className = val;
            },
          )),
    ),
  );
}

Widget editClassPrice(Class template) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 140,
        right: 140,
        bottom: 5,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(color: snow),
          child: TextField(
            autocorrect: true,
            cursorColor: ocean,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: shark60, width: 2)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 2)),
              hintText: 'Price',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: (val) {
              template.classPrice = double.parse(val);
            },
          )),
    ),
  );
}

Widget editClassDescription(Class template) {
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
            autocorrect: true,
            cursorColor: ocean,
            maxLines: null,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 18,
                fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Describe your class',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            onChanged: (val) {
              template.classDescription = val;
            },
          )),
    ),
  );
}
