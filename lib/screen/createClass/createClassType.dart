// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/home/home.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/createClass/createClassDetails.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class CreateClassType extends StatefulWidget {
  const CreateClassType({Key? key}) : super(key: key);

  @override
  State<CreateClassType> createState() => _CreateClassType();
}

Class classTemplate = Class(
    className: "",
    classDescription: "",
    classImage: "",
    classType: ClassType.solo,
    classLocation: "",
    classRating: 0,
    classReview: 0,
    classPrice: 0,
    classTrainer: "",
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://www.ahigherbranch.com/wp-content/uploads/2019/06/David-Goggins.jpg',
    classTrainerUsername: '',
    classTrainerFirstName: '',
    classUserRequirements: '',
    classWhatToExpect: '');

// enum ClassType { solo, group, virtual }

class _CreateClassType extends State<CreateClassType> {
  //variables
  Color _currentBorderColorSolo = snow;
  Color _currentIconBackgroundColorSolo = bone60;
  Color _currentIconColorSolo = strawberry;
  Color _currentTextColorSolo = jetBlack;
  Color _currentBorderColorGroup = snow;
  Color _currentIconBackgroundColorGroup = bone60;
  Color _currentIconColorGroup = strawberry;
  Color _currentTextColorGroup = jetBlack;
  Color _currentBorderColorVirtual = snow;
  Color _currentIconBackgroundColorVirtual = bone60;
  Color _currentIconColorVirtual = strawberry;
  Color _currentTextColorVirtual = jetBlack;

  void _ButtonOnPressed(classType) {
    setState(() {
      _currentBorderColorSolo = snow;
      _currentIconBackgroundColorSolo = bone60;
      _currentIconColorSolo = strawberry;
      _currentTextColorSolo = jetBlack;
      _currentBorderColorGroup = snow;
      _currentIconBackgroundColorGroup = bone60;
      _currentIconColorGroup = strawberry;
      _currentTextColorGroup = jetBlack;
      _currentBorderColorVirtual = snow;
      _currentIconBackgroundColorVirtual = bone60;
      _currentIconColorVirtual = strawberry;
      _currentTextColorVirtual = jetBlack;
      switch (classType) {
        case ClassType.solo:
          _currentBorderColorSolo = strawberry;
          _currentIconBackgroundColorSolo = strawberry;
          _currentIconColorSolo = snow;
          _currentTextColorSolo = snow;
          break;
        case ClassType.group:
          _currentBorderColorGroup = strawberry;
          _currentIconBackgroundColorGroup = strawberry;
          _currentIconColorGroup = snow;
          _currentTextColorGroup = snow;
          break;
        case ClassType.virtual:
          _currentBorderColorVirtual = strawberry;
          _currentIconBackgroundColorVirtual = strawberry;
          _currentIconColorVirtual = snow;
          _currentTextColorVirtual = snow;
          break;
      }
    });
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
                  print("Cancel");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true, builder: (context) => Home()));
                },
                child: Text("Cancel", style: logInPageNavigationButtons),
              ),
            ),
          ],
        ),
      ),

      //Body
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pageTitle(),

            //Class Type selection
            Padding(
              padding: const EdgeInsets.only(
                left: 26,
                right: 26,
                top: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //One-on-one selection
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                          color: _currentBorderColorSolo,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _currentBorderColorSolo,
                            width: 3,
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 40,
                              right: 12,
                              top: 25,
                              bottom: 25,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _currentIconBackgroundColorSolo,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: SvgPicture.asset(
                                'assets/icons/navigationBarIcon/User.svg',
                                color: _currentIconColorSolo,
                              ),
                            ),
                          ),
                          Text('One-on-one training',
                              style: TextStyle(
                                color: _currentTextColorSolo,
                                fontFamily: 'SFDisplay',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                    onTap: () => {
                      setState(() {
                        _ButtonOnPressed(ClassType.solo);
                        HapticFeedback.mediumImpact();
                        // print(ClassType.solo.toString().split('.').last);
                        classTemplate.classType = ClassType.solo;
                      })
                    },
                  ),

                  //Group selection
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                          color: _currentBorderColorGroup,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _currentBorderColorGroup,
                            width: 3,
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 40,
                              right: 12,
                              top: 25,
                              bottom: 25,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _currentIconBackgroundColorGroup,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: SvgPicture.asset(
                                "assets/icons/Group.svg",
                                color: _currentIconColorGroup,
                              ),
                            ),
                          ),
                          Text('Group session',
                              style: TextStyle(
                                color: _currentTextColorGroup,
                                fontFamily: 'SFDisplay',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                    onTap: () => {
                      setState(() {
                        _ButtonOnPressed(ClassType.group);
                        HapticFeedback.mediumImpact();
                        // print(ClassType.group.toString().split('.').last);
                        classTemplate.classType = ClassType.group;
                      })
                    },
                  ),

                  //Virtual selection
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear,
                      decoration: BoxDecoration(
                          color: _currentBorderColorVirtual,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _currentBorderColorVirtual,
                            width: 3,
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 40,
                              right: 12,
                              top: 25,
                              bottom: 25,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: _currentIconBackgroundColorVirtual,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(10),
                              height: 75,
                              width: 75,
                              child: SvgPicture.asset(
                                "assets/icons/Virtual.svg",
                                color: _currentIconColorVirtual,
                              ),
                            ),
                          ),
                          Text('Virtual program',
                              style: TextStyle(
                                color: _currentTextColorVirtual,
                                fontFamily: 'SFDisplay',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      ),
                    ),
                    onTap: () => {
                      setState(() {
                        _ButtonOnPressed(ClassType.virtual);
                        HapticFeedback.mediumImpact();
                        // print(ClassType.virtual.toString().split('.').last);
                        classTemplate.classType = ClassType.virtual;
                      })
                    },
                  ),
                ],
              ),
            ),

            //Slider Stuff
            Padding(
              padding: const EdgeInsets.only(top: 36.0, bottom: 45),
              child: GestureDetector(
                  child: LoginFooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: "Continue",
                  ),
                  onTap: () => {
                        print("Continue button pressed"),
                        Navigator.of(context).push(CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => CreateClassDetails(
                                classTemplate: classTemplate)))
                      }),
            ),
          ],
        ),
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
            'What type of class are you listing?',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
