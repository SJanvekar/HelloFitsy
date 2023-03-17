// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/createClassTimeList.dart';
import 'package:balance/screen/createClass/createClassStep1SelectType.dart';
import 'package:balance/screen/createClass/scheduleCalendar.dart';
import 'package:balance/screen/createClass/trainerCalendar.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateClassSchedule extends StatefulWidget {
  const CreateClassSchedule({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassSchedule> createState() => _CreateClassSchedule();
}

class _CreateClassSchedule extends State<CreateClassSchedule> {
  //variables

  Widget timeList() {
    return Expanded(
      flex: 1,
      child: CreateClassTimeList(classTimes: widget.classTemplate.classTimes),
    );
  }

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
                  Navigator.of(context).pop();
                },
                child: Text("Back", style: logInPageNavigationButtons),
              ),
            ),
          ],
        ),
      ),

      //Body
      body: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pageTitle(),
            Expanded(child: ScheduleCalendar(classTemplate: classTemplate)),

            //Slider Stuff
            Padding(
              padding: const EdgeInsets.only(top: 36.0, bottom: 45),
              child: GestureDetector(
                  child: FooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: "Continue",
                  ),
                  onTap: () {
                    print(widget.classTemplate.className);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateClassPicture(
                            classTemplate: widget.classTemplate)));
                  }),
            ),
          ],
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
        left: 40,
        right: 40,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Select available dates and times for your session',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}

//Add Time Button
Widget addTimeButton(BuildContext context, Class classTemplate) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, right: 26, bottom: 20),
    child: GestureDetector(
        child: Text(
          'Add time',
          style: TextStyle(
            fontFamily: 'SFDisplay',
            color: strawberry,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        onTap: () {
          print(classTemplate.className);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ScheduleCalendar(classTemplate: classTemplate)));
        }),
  );
}
