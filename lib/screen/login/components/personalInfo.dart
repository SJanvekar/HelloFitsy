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
import '../../../feModels/userModel.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

User userTemplate = User(
  // isActive: true,
  userType: UserType.Trainee,
  profileImageURL: "",
  firstName: "",
  lastName: "",
  userName: "",
  userEmail: "",
  password: "",
);

var passwordConfirmed;

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
  Color _currentIconColorTrainee = jetBlack40;
  Color _currentBorderColorTrainer = strawberry;
  Color _currentIconColorTrainer = snow;
  String _showHideIcon = 'assets/icons/generalIcons/hidePassword.svg';
  String _showHideIconConfirm = 'assets/icons/generalIcons/hidePassword.svg';
  double _showHideIconHeight = 18.0;
  double _showHideIconHeightConfirm = 18.0;
  Color _eyeIconColorPassword = jetBlack40;
  Color _eyeIconColorConfirmPassword = jetBlack40;

  void _ButtonOnPressed() {
    setState(() {
      if (_buttonPressed == true) {
        _currentBorderColorTrainer = strawberry;
        _currentIconColorTrainer = snow;
        _currentBorderColorTrainee = snow;
        _currentIconColorTrainee = jetBlack40;
      } else {
        _currentBorderColorTrainer = snow;
        _currentIconColorTrainer = jetBlack40;
        _currentBorderColorTrainee = strawberry;
        _currentIconColorTrainee = snow;
      }
    });
  }

  void _changePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
      if (_passwordVisibility == true) {
        _showHideIcon = 'assets/icons/generalIcons/hidePassword.svg';
        _eyeIconColorPassword = jetBlack40;
        _showHideIconHeight = 18.0;
      } else {
        _showHideIcon = 'assets/icons/generalIcons/showPassword.svg';
        _eyeIconColorPassword = strawberry;
        _showHideIconHeight = 14.0;
      }
    });
  }

  void _changePasswordConfirmVisibility() {
    setState(() {
      _passwordConfirmVisibility = !_passwordConfirmVisibility;
      if (_passwordConfirmVisibility == true) {
        _showHideIconConfirm = 'assets/icons/generalIcons/hidePassword.svg';
        _eyeIconColorConfirmPassword = jetBlack40;
        _showHideIconHeightConfirm = 18.0;
      } else {
        _showHideIconConfirm = 'assets/icons/generalIcons/showPassword.svg';
        _eyeIconColorConfirmPassword = strawberry;
        _showHideIconHeightConfirm = 14.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double boxWidth = ((MediaQuery.of(context).size.width) - 10 - (26 * 2)) / 2;
    return GestureDetector(
      child: Scaffold(
        backgroundColor: snow,

        //AppBar
        appBar: AppBar(
          toolbarHeight: 50,
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
                          duration: Duration(milliseconds: 50),
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
                                  "assets/icons/generalIcons/trainer.svg",
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
                            userTemplate.userType = UserType.Trainer;
                          })
                        },
                      ),
                    ),

                    //Trainee selection
                    GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 50),
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
                                "assets/icons/generalIcons/user.svg",
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

                          userTemplate.userType = UserType.Trainee;
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
                  left: 26.0,
                  right: 26.0,
                ),
                child: textInputFirstLastName(boxWidth),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 26.0,
                  right: 26.0,
                ),
                child: textInputUsername(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 26.0,
                  right: 26.0,
                ),
                child: textInputEmail(context),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 26.0,
                  right: 26.0,
                ),
                child: textInputPasswordAndConfirm(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 55),
          child: GestureDetector(
              child: LoginFooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: "Continue",
              ),
              onTap: () => {
                    print(userTemplate.password),
                    // if (userTemplate.password == passwordConfirmed)
                    //   {
                    //     //SNTG
                    //     passwordCheck = true
                    //   }
                    // else
                    //   {passwordCheck = false},
                    // print('not the same password bitch'),
                    // if (userTemplate.userEmail == null)
                    //   {emailValid = false}
                    // else
                    //   {
                    //     emailValid = RegExp(
                    //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    //         .hasMatch(userTemplate.userEmail)
                    //   },
                    // print(emailValid),
                    // if (passwordCheck && emailValid)
                    //   {

                    //   }
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProfilePictureUpload(userTemplate: userTemplate))),
                  }),
        ),
      ),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  //Password 1&2
  Widget textInputPasswordAndConfirm() {
    return Column(
      children: [
        Container(
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
                    'assets/icons/generalIcons/lock.svg',
                    width: 20,
                    height: 25,
                    color: jetBlack40,
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
                      color: shark,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onChanged: (val) {
                    userTemplate.password = val;
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),

                  //Switch the eyeOff icon to the eye Icon on Tap
                  child: GestureDetector(
                    child: SvgPicture.asset(
                      _showHideIcon,
                      color: _eyeIconColorPassword,
                      height: _showHideIconHeight,
                    ),
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
                      'assets/icons/generalIcons/lock.svg',
                      width: 21,
                      height: 25,
                      color: jetBlack40,
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
                        color: shark,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onChanged: (val) {
                      passwordConfirmed = val;
                    },
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),

                    //Switch the eyeOff icon to the eye Icon on Tap
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        _showHideIconConfirm,
                        color: _eyeIconColorConfirmPassword,
                        height: _showHideIconHeightConfirm,
                      ),
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
        padding: EdgeInsets.only(top: 20),
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
      child:
          Text('Are you looking to train or learn?', style: logInPageBodyText));
}

//User First + Last Name input
Widget textInputFirstLastName(boxWidth) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: boxWidth,
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
                  'assets/icons/generalIcons/user.svg',
                  height: 22.5,
                  width: 18,
                  color: jetBlack40,
                )),
              ),
            ),
            Expanded(child: textInputFirstName()),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: boxWidth,
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
              Expanded(child: textInputLastName()),
            ],
          ),
        ),
      ),
    ],
  );
}

//FastName
Widget textInputFirstName() {
  return TextField(
    autocorrect: true,
    autofocus: true,
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
        color: shark,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    onChanged: (val) {
      userTemplate.firstName = val;
    },
    textInputAction: TextInputAction.next,
  );
}

//LastName
Widget textInputLastName() {
  return TextField(
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
        color: shark,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),
    onChanged: (val) {
      userTemplate.lastName = val;
    },
    textInputAction: TextInputAction.next,
  );
}

//Username
Widget textInputUsername() {
  return Container(
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
              'assets/icons/generalIcons/user.svg',
              height: 22.5,
              width: 18.0,
              color: jetBlack40,
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
                color: shark,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (val) {
              userTemplate.userName = val;
            },
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    ),
  );
}

//Email
Widget textInputEmail(BuildContext context) {
  return Container(
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
              'assets/icons/generalIcons/mail.svg',
              width: 18,
              color: jetBlack40,
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
                color: shark,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (val) {
              userTemplate.userEmail = val;
            },
            textInputAction: TextInputAction.next,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: GestureDetector(
              child: SvgPicture.asset(
                  'assets/icons/generalIcons/information.svg',
                  color: jetBlack40,
                  height: 20,
                  width: 20),
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
      height: 225.0,
      width: 280.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Text(
              'Privacy Notice',
              style: disclaimerTitle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Text(
                  'This email will not be shared with any person or organization, it is for authentication and verification purposes only',
                  style: TextStyle(
                    fontFamily: 'SFDisplay',
                    color: jetBlack60,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 0.0)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 70, right: 70),
                child: Container(
                  height: 35,
                  width: 323,
                  decoration: BoxDecoration(
                      color: strawberry,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    'Confirm',
                    style: TextStyle(
                        color: snow,
                        fontSize: 13,
                        fontFamily: 'SFDisplay',
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  )),
                ),
              ))
        ],
      ),
    ),
  );
}
