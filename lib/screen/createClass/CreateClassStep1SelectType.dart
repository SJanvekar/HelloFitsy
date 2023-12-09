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
  CreateClassSelectType({
    Key? key,
    required this.isEditMode,
    required this.isTypeSelected,
    required this.classTemplate,
  }) : super(key: key);
  bool isEditMode;
  bool isTypeSelected;
  Class classTemplate;

  @override
  State<CreateClassSelectType> createState() => _CreateClassSelectType();
}

late Class classTemplate;

// enum ClassType { solo, group, virtual }

class _CreateClassSelectType extends State<CreateClassSelectType> {
  //variables
  Color _currentBorderColorSolo = snow;
  Color _currentTextColorSolo = jetBlack;
  Color _currentBorderColorGroup = snow;
  Color _currentTextColorGroup = jetBlack;
  Color _currentBorderColorVirtual = snow;
  Color _currentTextColorVirtual = jetBlack;

  void _buttonOnPressed(classType) {
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

  void checkClassTemplateValues() {
    if (widget.isEditMode) {
      classTemplate = widget.classTemplate;
      widget.classTemplate.isEditMode = widget.isEditMode;
      _buttonOnPressed(widget.classTemplate.classType);
    } else {
      classTemplate = Class(
        classID: '',
        className: '',
        classDescription: '',
        classType: ClassType.Solo,
        classLocationName: '',
        classLatitude: 0,
        classLongitude: 0,
        classOverallRating: 0,
        classReviewsAmount: 0,
        classPrice: 0,
        classTrainerID: '',
        classTimes: [],
        updatedClassTimes: [],
        cancelledClassTimes: [],
        classCategories: [],
        classUserRequirements: '',
        classWhatToExpect: '',
        classImageUrl: '',
      );
    }
  }

  //----------
  @override
  void initState() {
    super.initState();
    checkClassTemplateValues();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: snow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 26.0,
            ),
            child: GestureDetector(
              child: Text("Cancel", style: logInPageNavigationButtons),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          pageTitle(),

          //Class Type selection
          Padding(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 35),
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
                      _buttonOnPressed(ClassType.Solo);
                      HapticFeedback.mediumImpact();
                      classTemplate.classType = ClassType.Solo;
                      widget.isTypeSelected = true;
                    })
                  },
                ),

                //Group selection
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
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
                        _buttonOnPressed(ClassType.Group);
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
                      _buttonOnPressed(ClassType.Virtual);
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
                        bottom: 45.0,
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
                                  fullscreenDialog:
                                      !widget.classTemplate.isEditMode,
                                  builder: (context) => CreateClassDescription(
                                      classTemplate: classTemplate)))
                            }
                        }),
              ],
            ),
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
