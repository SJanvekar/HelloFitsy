// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/home/home.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/createClass/createClassStep2Description.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class CreateClassSelectType extends StatefulWidget {
  CreateClassSelectType(
      {Key? key, required this.isTypeSelected, required this.classTemplate})
      : super(key: key);

  bool isTypeSelected = false;
  Class classTemplate;

  @override
  State<CreateClassSelectType> createState() => _CreateClassSelectType();
}

Class classTemplate = Class(
    className: '',
    classDescription: '',
    classType: ClassType.Solo,
    classLocationName: '',
    classLatitude: 0,
    classLongitude: 0,
    classOverallRating: 0,
    classReviewsAmount: 0,
    classPrice: 0,
    classTrainer: '',
    classTimes: [],
    trainerImageUrl: '',
    // trainerUsername: '',
    trainerFirstName: '',
    trainerLastName: '',
    classUserRequirements: '',
    classWhatToExpect: '',
    classImageUrl: '');

// enum ClassType { solo, group, virtual }

class _CreateClassSelectType extends State<CreateClassSelectType> {
  //variables
  Color _currentBorderColorSolo = snow;
  Color _currentTextColorSolo = jetBlack;
  Color _currentBorderColorGroup = snow;
  Color _currentTextColorGroup = jetBlack;
  Color _currentBorderColorVirtual = snow;
  Color _currentTextColorVirtual = jetBlack;

  void _ButtonOnPressed(classType) {
    setState(() {
      _currentBorderColorSolo = snow;
      _currentTextColorSolo = jetBlack;
      _currentBorderColorGroup = snow;
      _currentTextColorGroup = jetBlack;
      _currentBorderColorVirtual = snow;
      _currentTextColorVirtual = jetBlack;
      switch (classType) {
        case ClassType.Solo:
          _currentBorderColorSolo = strawberry;
          _currentTextColorSolo = snow;
          break;
        case ClassType.Group:
          _currentBorderColorGroup = strawberry;
          _currentTextColorGroup = snow;
          break;
        case ClassType.Virtual:
          _currentBorderColorVirtual = strawberry;
          _currentTextColorVirtual = snow;
          break;
      }
    });
  }

  //----------
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: snow,
      borderRadius: BorderRadius.circular(20),
      child:

          //Body
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26.0, top: 30),
            child: GestureDetector(
              child: Text("Cancel", style: logInPageNavigationButtons),
              onTap: () {
                Navigator.of(context).pop(CupertinoPageRoute(
                    fullscreenDialog: true, builder: (context) => Home()));
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pageTitle(),

              //Class Type selection
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26, top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //One-on-one selection
                    GestureDetector(
                      child: AnimatedContainer(
                        height: 85,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                          color: _currentBorderColorSolo,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgPicture.asset(
                                'assets/icons/generalIcons/oneOnOne.svg',
                                color: _currentTextColorSolo,
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
                          _ButtonOnPressed(ClassType.Solo);
                          HapticFeedback.mediumImpact();
                          classTemplate.classType = ClassType.Solo;
                          widget.isTypeSelected = true;
                        })
                      },
                    ),

                    //Group selection
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                      child: GestureDetector(
                        child: AnimatedContainer(
                          height: 85.0,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.linear,
                          decoration: BoxDecoration(
                            color: _currentBorderColorGroup,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SvgPicture.asset(
                                  "assets/icons/generalIcons/group.svg",
                                  color: _currentTextColorGroup,
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
                            _ButtonOnPressed(ClassType.Group);
                            HapticFeedback.mediumImpact();
                            classTemplate.classType = ClassType.Group;
                            widget.isTypeSelected = true;
                          })
                        },
                      ),
                    ),

                    //Virtual selection
                    GestureDetector(
                      child: AnimatedContainer(
                        height: 85,
                        duration: Duration(milliseconds: 100),
                        curve: Curves.linear,
                        decoration: BoxDecoration(
                          color: _currentBorderColorVirtual,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SvgPicture.asset(
                                "assets/icons/generalIcons/virtual.svg",
                                color: _currentTextColorVirtual,
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
                          _ButtonOnPressed(ClassType.Virtual);
                          HapticFeedback.selectionClick();
                          classTemplate.classType = ClassType.Virtual;
                          widget.isTypeSelected = true;
                        })
                      },
                    ),
                    //Bottom Navigation Bar
                    GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 30,
                            bottom: 46,
                          ),
                          child: FooterButton(
                            buttonColor: strawberry,
                            buttonText: 'Continue',
                            textColor: snow,
                          ),
                        ),
                        onTap: () => {
                              if (widget.isTypeSelected == true)
                                {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) =>
                                          CreateClassDescription(
                                              classTemplate: classTemplate)))
                                }
                            }),
                  ],
                ),
              ),
            ],
          ),
        ],
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
          padding: EdgeInsets.only(top: 40),
          decoration: BoxDecoration(color: snow),
          child: Text(
            'What type of class are you listing?',
            style: pageTitles,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
