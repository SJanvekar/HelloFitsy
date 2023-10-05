// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/Constants.dart';

import 'package:balance/example.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import '../../../feModels/UserModel.dart';

class PersonalInfo extends StatefulWidget {
  PersonalInfo(
      {Key? key, required this.authTemplate, required this.userTemplate})
      : super(key: key);

  Auth authTemplate;
  User userTemplate;
  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

var passwordConfirmed;

bool passwordCheck = false;
bool emailValid = false;

class _PersonalInfoState extends State<PersonalInfo> {
  //variables
  double range = 0;
  bool _passwordVisibility = true;
  bool _passwordConfirmVisibility = true;
  String _showHideIcon = 'assets/icons/generalIcons/hidePassword.svg';
  String _showHideIconConfirm = 'assets/icons/generalIcons/hidePassword.svg';
  double _showHideIconHeight = 18.0;
  double _showHideIconHeightConfirm = 18.0;
  Color _eyeIconColorPassword = jetBlack40;
  Color _eyeIconColorConfirmPassword = jetBlack40;

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

              //User text input fields
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 26.0,
                  right: 26.0,
                ),
                child: textInputFullName(),
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
                child: textInputEmailOrPhone(context, true),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 26.0,
                  right: 26.0,
                ),
                child: textInputEmailOrPhone(context, false),
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
          padding: const EdgeInsets.only(bottom: 55, left: 26.0, right: 26.0),
          child: GestureDetector(
              child: FooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: "Continue",
              ),
              onTap: () => {
                    if (widget.authTemplate.password == passwordConfirmed)
                      {passwordCheck = true}
                    else
                      {
                        print(
                            'Not the same, original: ${widget.authTemplate.password}, confirmed: $passwordConfirmed'),
                        passwordCheck = false
                      },
                    if (widget.authTemplate.userEmail == null)
                      {emailValid = false}
                    else
                      {
                        emailValid = EmailValidator.validate(
                            widget.authTemplate.userEmail)
                      },
                    if (passwordCheck && emailValid)
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfilePictureUpload(
                                authTemplate: widget.authTemplate,
                                userTemplate: widget.userTemplate))),
                      }
                    else if (!emailValid)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            duration: Duration(milliseconds: 1500),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.3,
                                left: 30.0,
                                right: 30.0),
                            content: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                  color: strawberry,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: jetBlack.withOpacity(0.01),
                                      spreadRadius: 0,
                                      blurRadius: 38,
                                      offset: Offset(
                                          0, 24), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: jetBlack.withOpacity(0.06),
                                      spreadRadius: 0,
                                      blurRadius: 46,
                                      offset: Offset(
                                          0, 9), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: jetBlack.withOpacity(0.10),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: Offset(
                                          0, 11), // changes position of shadow
                                    ),
                                  ]),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'You have entered an invalid email, please try again.',
                                  style: TextStyle(
                                      color: snow,
                                      fontSize: 16,
                                      fontFamily: 'SFDisplay',
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ))),
                      }
                    else if (!passwordCheck)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Padding(
                            padding: const EdgeInsets.only(bottom: 320.0),
                            child: passwordCheckSnackbar(),
                          ),
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ))
                      }
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
                    widget.authTemplate.password = val;
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

//User First + Last Name input
  Widget textInputFullName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 5.0,
            left: 2.0,
          ),
          child: Text(
            'Name',
            style: logInPageTextInputTitle,
          ),
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: snow,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: jetBlack40)),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: textFieldFullName(),
          )),
        ),
      ],
    );
  }

//FastName
  Widget textFieldFullName() {
    return TextField(
      autocorrect: true,
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(
          overflow: TextOverflow.fade,
          fontFamily: 'SFDisplay',
          color: jetBlack,
          fontSize: 16,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration.collapsed(
        border: InputBorder.none,
        hintText: 'Enter your first & last name',
        hintStyle: const TextStyle(
          fontFamily: 'SFDisplay',
          color: jetBlack40,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onChanged: (val) {
        widget.userTemplate.firstName = val;
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
        hintText: '',
        hintStyle: TextStyle(
          fontFamily: 'SFDisplay',
          color: shark,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onChanged: (val) {
        widget.userTemplate.lastName = val;
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
                widget.userTemplate.userName = val;
              },
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }

//Email
  Widget textInputEmailOrPhone(BuildContext context, bool isEmail) {
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
                //HARD CODED - MUST CHANGE replace with phone icon asset
                isEmail
                    ? 'assets/icons/generalIcons/mail.svg'
                    : 'assets/icons/generalIcons/mail.svg',
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
                hintText: isEmail ? 'Email' : 'Phone',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: shark,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (val) {
                if (isEmail) {
                  widget.authTemplate.userEmail = val;
                } else {
                  widget.authTemplate.userPhone = val;
                }
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

  Widget passwordCheckSnackbar() {
    return Container(
      height: 50,
      width: 323,
      decoration: BoxDecoration(
        color: strawberry,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Text(
        'Your passwords do not match, please try again.',
        style: TextStyle(
            color: snow,
            fontSize: 15,
            fontFamily: 'SFDisplay',
            letterSpacing: 0.5,
            fontWeight: FontWeight.w500),
      )),
    );
  }
}
