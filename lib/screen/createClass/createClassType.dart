// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
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

var classType;

enum ClassType { solo, group, virtual }

class _CreateClassType extends State<CreateClassType> {
  //variables
  bool _buttonPressed = false;
  // final passwordController = TextEditingController();

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

  // @override
  // void initState() {
  //   super.initState();

  //   // Start listening to changes.
  //   passwordController.addListener(_changePasswordVisibility);
  //   passwordController.addListener(_changePasswordConfirmVisibility);
  // }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the widget tree.
  //   // This also removes the _printLatestValue listener.
  //   passwordController.dispose();
  //   super.dispose();
  // }

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
                      fullscreenDialog: true, builder: (context) => Login()));
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
                        _buttonPressed = true;
                        _ButtonOnPressed(ClassType.solo);
                        HapticFeedback.mediumImpact();
                        // print(ClassType.solo.toString().split('.').last);
                        classType = ClassType.solo.toString().split('.').last;
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
                                "assets/icons/Dumbell.svg",
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
                        _buttonPressed = true;
                        _ButtonOnPressed(ClassType.group);
                        HapticFeedback.mediumImpact();
                        // print(ClassType.group.toString().split('.').last);
                        classType = ClassType.group.toString().split('.').last;
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
                                "assets/icons/Dumbell.svg",
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
                        _buttonPressed = true;
                        _ButtonOnPressed(ClassType.virtual);
                        HapticFeedback.mediumImpact();
                        // print(ClassType.virtual.toString().split('.').last);
                        classType =
                            ClassType.virtual.toString().split('.').last;
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePictureUpload()))
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
