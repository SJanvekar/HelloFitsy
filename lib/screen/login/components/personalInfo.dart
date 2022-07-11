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

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

var userType,
    firstName,
    lastName,
    userName,
    userEmail,
    password,
    passwordConfirmed;

bool passwordCheck = false;
bool emailValid = false;

class _PersonalInfoState extends State<PersonalInfo> {
  //variables
  double range = 0;
  bool _buttonPressed = false;
  // final passwordController = TextEditingController();
  bool _passwordVisibility = true;
  bool _passwordConfirmVisibility = true;
  Color _currentBorderColorTrainee = snow;
  Color _currentIconColorTrainee = jetBlack;
  Color _currentBorderColorTrainer = strawberry;
  Color _currentIconColorTrainer = snow;

  void _ButtonOnPressed() {
    setState(() {
      if (_buttonPressed == true) {
        _currentBorderColorTrainer = strawberry;
        _currentIconColorTrainer = snow;
        _currentBorderColorTrainee = snow;
        _currentIconColorTrainee = jetBlack;
      } else {
        _currentBorderColorTrainer = snow;
        _currentIconColorTrainer = jetBlack;
        _currentBorderColorTrainee = strawberry;
        _currentIconColorTrainee = snow;
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

  void _changePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
    });
  }

  void _changePasswordConfirmVisibility() {
    setState(() {
      _passwordConfirmVisibility = !_passwordConfirmVisibility;
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
            pageText(),

            //Trainer or Trainee selection
            Padding(
              padding: const EdgeInsets.only(
                left: 70.5,
                right: 70.5,
                top: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Trainer selection
                  Padding(
                    padding: EdgeInsets.only(
                      right: 34,
                    ),
                    child: GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.linear,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: _currentBorderColorTrainer,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _currentBorderColorTrainer,
                              width: 3,
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 18,
                                bottom: 11,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Dumbell.svg",
                                color: _currentIconColorTrainer,
                                height: 28.52,
                                width: 53.86,
                              ),
                            ),
                            Text('Trainer',
                                style: TextStyle(
                                  color: _currentIconColorTrainer,
                                  fontFamily: 'SFDisplay',
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        ),
                      ),
                      onTap: () => {
                        setState(() {
                          _buttonPressed = true;
                          _ButtonOnPressed();
                          HapticFeedback.mediumImpact();
                          userType = 'Trainer';
                        })
                      },
                    ),
                  ),

                  //Trainee selection
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: _currentBorderColorTrainee,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _currentBorderColorTrainee, width: 3)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 18,
                              bottom: 11,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/UserIconSolid.svg",
                              color: _currentIconColorTrainee,
                              height: 27.72,
                              width: 32.76,
                            ),
                          ),
                          Text(
                            'Trainee',
                            style: TextStyle(
                                color: _currentIconColorTrainee,
                                fontFamily: 'SFDisplay',
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                    onTap: () => {
                      setState(() {
                        _buttonPressed = false;
                        _ButtonOnPressed();
                        HapticFeedback.mediumImpact();
                        userType = 'Trainee';
                      })
                    },
                  )
                ],
              ),
            ),

            //User text input fields
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: textInputFirstLastName(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: textInputUsername(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: textInputEmail(context),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: textInputPasswordAndConfirm(),
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

  //Password 1&2
  Widget textInputPasswordAndConfirm() {
    return Column(
      children: [
        Container(
          width: 323,
          height: 50,
          decoration: BoxDecoration(
            color: bone60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.only(left: 22, right: 10),
                  child: Center(
                      child: SvgPicture.asset(
                    'assets/icons/LockIcon.svg',
                    width: 21,
                    height: 25,
                    color: shark,
                  )),
                ),
              ),
              Expanded(
                child: TextField(
                  //Toggle this on and off with the guesture detector on the eyeOff icon
                  obscureText: _passwordVisibility,
                  autocorrect: true,
                  style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontFamily: 'SFDisplay',
                      color: jetBlack80,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: shark60,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (val) {
                    password = val;
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),

                  //Switch the eyeOff icon to the eye Icon on Tap
                  child: GestureDetector(
                    child: SvgPicture.asset('assets/icons/EyeCrossIcon.svg'),
                    onTap: () {
                      _changePasswordVisibility();
                    },
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Container(
            width: 323,
            height: 50,
            decoration: BoxDecoration(
              color: bone60,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22, right: 10),
                    child: Center(
                        child: SvgPicture.asset(
                      'assets/icons/LockIcon.svg',
                      width: 21,
                      height: 25,
                      color: shark,
                    )),
                  ),
                ),
                Expanded(
                  child: TextField(
                    //Toggle this on and off with the guesture detector on the eyeOff icon
                    obscureText: _passwordConfirmVisibility,
                    autocorrect: true,
                    style: const TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'SFDisplay',
                        color: jetBlack80,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                        fontFamily: 'SFDisplay',
                        color: shark60,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (val) {
                      passwordConfirmed = val;
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),

                    //Switch the eyeOff icon to the eye Icon on Tap
                    child: GestureDetector(
                      child: SvgPicture.asset('assets/icons/EyeCrossIcon.svg'),
                      onTap: () {
                        _changePasswordConfirmVisibility();
                      },
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Tell us about yourself',
          style: logInPageTitle,
        )),
  );
}

//PageText
Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: const [
          TextSpan(
              text: 'Are you looking to train or learn?',
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

//User First + Last Name input
Widget textInputFirstLastName() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 156.5,
        height: 50,
        decoration: BoxDecoration(
          color: bone60,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/icons/UserIcon.svg',
                  height: 22.5,
                  width: 18,
                  color: shark,
                )),
              ),
            ),
            Expanded(
              child: TextField(
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                    overflow: TextOverflow.fade,
                    fontFamily: 'SFDisplay',
                    color: jetBlack80,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'First Name',
                  hintStyle: const TextStyle(
                    fontFamily: 'SFDisplay',
                    color: shark60,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onChanged: (val) {
                  firstName = val;
                },
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: 156.5,
          height: 50,
          decoration: BoxDecoration(
            color: bone60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
              ),
              Expanded(
                child: TextField(
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                      overflow: TextOverflow.fade,
                      fontFamily: 'SFDisplay',
                      color: jetBlack80,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Last Name',
                    hintStyle: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: shark60,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (val) {
                    lastName = val;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

//Username
Widget textInputUsername() {
  return Container(
    width: 323,
    height: 50,
    decoration: BoxDecoration(
      color: bone60,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Center(
                child: SvgPicture.asset(
              'assets/icons/UserIcon.svg',
              height: 22.5,
              width: 18.0,
              color: shark,
            )),
          ),
        ),
        Expanded(
          child: TextField(
            autocorrect: true,
            style: const TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 15,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Username',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (val) {
              userName = val;
            },
          ),
        ),
      ],
    ),
  );
}

//Email
Widget textInputEmail(BuildContext context) {
  return Container(
    width: 323,
    height: 50,
    decoration: BoxDecoration(
      color: bone60,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Center(
                child: SvgPicture.asset(
              'assets/icons/MailIcon.svg',
              width: 18,
              color: shark,
            )),
          ),
        ),
        Expanded(
          child: TextField(
            autocorrect: true,
            style: const TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 15,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Email',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (val) {
              userEmail = val;
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: GestureDetector(
              child: SvgPicture.asset('assets/icons/InformationIcon.svg',
                  height: 20, width: 20),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        informationDialog(context));
              },
            ))
      ],
    ),
  );
}

//Email Info Box
Widget informationDialog(BuildContext context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Container(
      height: 250.0,
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Text(
              'Privacy Notice',
              style: logInPageTitle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(
                  'This email will not be shared with any person or organization, it is for authentication and verification purposes only',
                  style: TextStyle(
                    fontFamily: 'SFDisplay',
                    color: jetBlack40,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 0.0)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: LoginFooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: "Confirm",
              ))
        ],
      ),
    ),
  );
}
