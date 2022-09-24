// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassPicture.dart';
import 'package:balance/screen/createClass/createClassTimeList.dart';
import 'package:balance/screen/createClass/createClassType.dart';
import 'package:balance/screen/createClass/scheduleCalendar.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pageTitle(),
            pageSubtitle(),
            addTimeButton(context, widget.classTemplate),
            timeList(),

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
            'Set dates and times availability for your session',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}

//Page subtitle
Widget pageSubtitle() {
  return Padding(
    padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: const [
          TextSpan(
              text: 'Let people know when your classes are going to be running',
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: shark,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    ),
  );
}

//Add Time Button
Widget addTimeButton(BuildContext context, Class classTemplate) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, right: 26, bottom: 20),
    child: GestureDetector(
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset("assets/icons/addTime.svg"),
          ),
          Text(
            'Add time',
            style: TextStyle(
              fontFamily: 'SFDisplay',
              color: strawberry,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          )
        ]),
        onTap: () {
          print(classTemplate.className);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ScheduleCalendar(classTemplate: classTemplate)));
        }),
  );
}
