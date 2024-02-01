// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:convert';
import 'dart:ffi';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/Constants.dart';
import 'package:balance/Main.dart';
import 'package:balance/example.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/login/StartPage.dart';
import 'package:balance/screen/login/components/TrainerOrTrainee.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/BodyButton.dart';
import 'package:balance/sharedWidgets/categories/AddRemoveButton.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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
  String _showHideIcon = 'assets/icons/generalIcons/hidePassword.svg';
  double _showHideIconHeight = 18.0;
  Color _eyeIconColorPassword = jetBlack60;
  bool? checkedValue = false;

  void _changePasswordVisibility() {
    setState(() {
      _passwordVisibility = !_passwordVisibility;
      if (_passwordVisibility == true) {
        _showHideIcon = 'assets/icons/generalIcons/hidePassword.svg';
        _eyeIconColorPassword = jetBlack60;
        _showHideIconHeight = 18.0;
      } else {
        _showHideIcon = 'assets/icons/generalIcons/showPassword.svg';
        _eyeIconColorPassword = strawberry;
        _showHideIconHeight = 14.0;
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
          title: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        FitsyIconsSet1.arrowleft,
                        color: jetBlack60,
                        size: 15,
                      ),
                      const Text(
                        "Back",
                        style: logInPageNavigationButtons,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => ProfilePictureUpload(
                              authTemplate: authTemplate,
                              userTemplate: userTemplate,
                            )));
                  },
                ),
              ],
            ),
          ),
        ),

        //Body
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 26.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                pageTitle(),
                pageText(),

                //User text input fields
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 26.0),
                  child: Column(
                    children: [
                      textInputFullName(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 26.0),
                  child: textInputUsername(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 26.0),
                  child: textInputEmailOrPhone(context, true),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 26.0),
                  child: textInputEmailOrPhone(context, false),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 26.0),
                  child: textInputPasswordAndConfirm(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: ocean,
                    title: Semantics(
                      excludeSemantics: true,
                      child: RichText(
                          text: TextSpan(
                        style: logInPageBodyTextNote,
                        children: [
                          TextSpan(
                            text: "By pressing continue you agree with our ",
                          ),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ocean,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    'https://fitsytermsandco.crd.co'));
                              },
                          ),
                          TextSpan(
                            text: " and ",
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: ocean,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(
                                    Uri.parse('https://fitsyprivpol.crd.co'));
                              },
                          ),
                        ],
                      )),
                    ),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 55, left: 26.0, right: 26.0),
          child: GestureDetector(
              child: FooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: "Finish",
              ),
              onTap: () => {
                    //Removing PW confirmation for quicker flow

                    // if (widget.authTemplate.password == passwordConfirmed)
                    //   {passwordCheck = true}
                    // else
                    //   {
                    //     print(
                    //         'Not the same, original: ${widget.authTemplate.password}, confirmed: $passwordConfirmed'),
                    //     passwordCheck = false
                    //   },
                    if (widget.authTemplate.userEmail == null)
                      {emailValid = false}
                    else
                      {
                        emailValid = EmailValidator.validate(
                            widget.authTemplate.userEmail)
                      },
                    if (emailValid && !showError)
                      {
                        sendUserModel(),
                      }
                    else if (!emailValid)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            duration: Duration(milliseconds: 1500),
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01,
                                left: 30.0,
                                right: 30.0),
                            content: Container(
                              height: 65,
                              decoration: BoxDecoration(
                                  color: jetBlack,
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
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'You have entered an invalid email, please try again.',
                                  style: errorTextSnackBar,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ))),
                      }

                    //Removing PW confirmation for quicker flow

                    // else if (!passwordCheck)
                    //   {
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       content: Padding(
                    //         padding: const EdgeInsets.only(bottom: 320.0),
                    //         child: passwordCheckSnackbar(),
                    //       ),
                    //       behavior: SnackBarBehavior.floating,
                    //       duration: Duration(seconds: 2),
                    //       backgroundColor: Colors.transparent,
                    //       elevation: 0,
                    //     ))
                    //   }
                  }),
        ),
      ),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  //Send User Model

  void sendUserModel() {
    // widget.userTemplate.userID = '';
    widget.userTemplate.userBio = '';
    widget.userTemplate.stripeAccountID = '';
    widget.userTemplate.stripeCustomerID = '';

    //Auth Service Call
    AuthService()
        .signUp(widget.authTemplate, widget.userTemplate)
        .then((val) async {
      try {
        if (val.data['success']) {
          print('Successful user add');

          //Assign all userTemplate information to shared preferences for MainPage
          final sharedPrefs = await SharedPreferences.getInstance();

          // Safely encode user data and handle SharedPreferences exceptions
          final userData = jsonEncode(val.data['user'] ?? '');
          await _safeSetString(sharedPrefs, 'loggedUser', userData);

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          print("Sign up error: ${val.data['msg']}");
        }
      } catch (e) {
        print('Error: $e');
        // Handle any exception that might occur during the process
      }
    }).catchError((error) {
      print('Error during sign up: $error');
      // Handle errors during sign up process
    });
  }

// Function to safely set string in SharedPreferences with error handling
  Future<void> _safeSetString(
      SharedPreferences prefs, String key, String value) async {
    try {
      await prefs.setString(key, value);
    } catch (e) {
      print('Error setting SharedPreferences: $e');
      // Handle any exception that might occur during SharedPreferences set operation
      // For instance, consider fallback mechanisms or alternative approaches
    }
  }

  //Password 1&2
  Widget textInputPasswordAndConfirm() {
    return Column(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: snow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: jetBlack40),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/icons/generalIcons/lock.svg',
                  width: 20,
                  color: jetBlack60,
                )),
              ),
              Expanded(
                child: TextField(
                  //Toggle this on and off with the guesture detector on the eyeOff icon
                  obscureText: _passwordVisibility,
                  autocorrect: true,
                  style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack40,
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
        // Padding(
        //   padding: const EdgeInsets.only(top: 15),
        //   child: Container(
        //     height: 50,
        //     decoration: BoxDecoration(
        //       color: bone60,
        //       borderRadius: BorderRadius.circular(20),
        //     ),
        //     child: Row(
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(left: 8),
        //           child: Padding(
        //             padding: const EdgeInsets.only(left: 22, right: 10),
        //             child: Center(
        //                 child: SvgPicture.asset(
        //               'assets/icons/generalIcons/lock.svg',
        //               width: 21,
        //               height: 25,
        //               color: jetBlack40,
        //             )),
        //           ),
        //         ),
        //         Expanded(
        //           child: TextField(
        //             //Toggle this on and off with the guesture detector on the eyeOff icon
        //             obscureText: _passwordConfirmVisibility,
        //             autocorrect: true,
        //             style: const TextStyle(
        //                 overflow: TextOverflow.fade,
        //                 fontFamily: 'SFDisplay',
        //                 color: jetBlack80,
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w700),
        //             decoration: InputDecoration.collapsed(
        //               border: InputBorder.none,
        //               hintText: 'Confirm Password',
        //               hintStyle: const TextStyle(
        //                 fontFamily: 'SFDisplay',
        //                 color: shark,
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w500,
        //               ),
        //             ),
        //             onChanged: (val) {
        //               passwordConfirmed = val;
        //             },
        //             textInputAction: TextInputAction.done,
        //           ),
        //         ),
        //         Padding(
        //             padding: const EdgeInsets.only(right: 20, left: 10),

        //             //Switch the eyeOff icon to the eye Icon on Tap
        //             child: GestureDetector(
        //               child: SvgPicture.asset(
        //                 _showHideIconConfirm,
        //                 color: _eyeIconColorConfirmPassword,
        //                 height: _showHideIconHeightConfirm,
        //               ),
        //               onTap: () {
        //                 _changePasswordConfirmVisibility();
        //               },
        //             ))
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  //Page title
  Widget pageTitle() {
    return Container(
        padding: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Almost done!',
          style: logInPageTitleH1,
        ));
  }

  Widget pageText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 26.0),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          style: logInPageBodyText,
          children: [
            TextSpan(
              text: 'Fill out the following to wrap up your personal profile',
            )
          ],
        ),
      ),
    );
  }

//User First + Last Name input
  bool showError = false;
  Widget textInputFullName() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: snow,
            borderRadius: BorderRadius.circular(20),
            border: showError
                ? Border.all(color: strawberry)
                : Border.all(color: jetBlack40),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FitsyIconsSet1.user,
                  color: jetBlack60,
                  size: 20,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: textFieldFullName(),
                )),
              ],
            ),
          ),
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(
              top: 5.0,
              right: 5.0,
            ),
            child: Text('Please enter your fullname*', style: errorText),
          )
      ],
    );
  }

//FullName
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
      decoration: InputDecoration(
        errorStyle: TextStyle(color: strawberry),
        border: InputBorder.none,
        hintText: 'Fullname',
        hintStyle: const TextStyle(
          fontFamily: 'SFDisplay',
          color: jetBlack40,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      onChanged: (val) {
        //Split Val (First name and last name)
        List<String> nameParts = val.split(' ');

        //If both names are provided
        if (nameParts.length >= 2) {
          setState(() {
            widget.userTemplate.firstName = nameParts[0];
            widget.userTemplate.lastName = nameParts.sublist(1).join(' ');
            showError = false;
          });
        }
        //if only one name is provided
        else if (nameParts.length == 1) {
          setState(() {
            showError = true;
          });
        }
      },
      textInputAction: TextInputAction.next,
    );
  }

//Username
  Widget textInputUsername() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: snow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: jetBlack40),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Icon(
              FitsyIconsSet1.user,
              color: jetBlack60,
              size: 20,
            ),
          ),
          Expanded(
            child: TextField(
              autocorrect: true,
              style: const TextStyle(
                  overflow: TextOverflow.fade,
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: 'Username',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
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
      height: 60,
      decoration: BoxDecoration(
        color: snow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: jetBlack40),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Center(
                child: SvgPicture.asset(
              //HARD CODED - MUST CHANGE replace with phone icon asset
              isEmail
                  ? 'assets/icons/generalIcons/mail.svg'
                  : 'assets/icons/generalIcons/phone.svg',
              width: 18,
              color: jetBlack60,
            )),
          ),
          Expanded(
            child: TextField(
              autocorrect: true,
              style: const TextStyle(
                  overflow: TextOverflow.fade,
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: isEmail ? 'Email' : 'Phone',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
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
                    color: jetBlack60,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 25.0,
                ),
                child: Text(
                  'Privacy Notice',
                  style: logInPageTitleH4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Center(
                  child: Text(
                    'This information will not be shared with any person or organization, it is for authentication and verification purposes only',
                    style: logInPageBodyTextNote,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 0.0)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: BodyButton(
                      buttonColor: strawberry,
                      textColor: snow,
                      buttonText: 'Confirm'))
            ],
          ),
        ),
      ),
    );
  }
}
