import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/userModel.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';

import '../../../main.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

var account, password, token;

User userTemplate = User(
  isActive: true,
  userType: UserType.Trainee,
  profileImageURL: "",
  firstName: "",
  lastName: "",
  userName: "",
  userEmail: "",
  password: "",
);

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          backgroundColor: snow,
          appBar: AppBar(
            toolbarHeight: 50,
            centerTitle: false,
            elevation: 0,
            backgroundColor: snow,
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(
                left: 0,
                right: 158,
              ),
              child: TextButton(
                onPressed: () {
                  print("Personal Information Pressed");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => PersonalInfo()));
                },
                child: Text("Cancel", style: logInPageNavigationButtons),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  typeFace(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: textInputUsername(),
                  ),

                  //TextInput Password
                  Container(
                    width: 326,
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
                            padding: const EdgeInsets.only(left: 21, right: 12),
                            child: Center(
                                child: SvgPicture.asset(
                              'assets/icons/generalIcons/lock.svg',
                              color: jetBlack40,
                            )),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            // onSubmitted: (val) {
                            //   AuthService()
                            //       .signIn(account, password)
                            //       .then((val) {
                            //     if (val.data['success']) {
                            //       token = val.data['token'];
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(SnackBar(
                            //         content: Padding(
                            //           padding:
                            //               const EdgeInsets.only(bottom: 320.0),
                            //           child: successfulSignInTemp(),
                            //         ),
                            //         behavior: SnackBarBehavior.floating,
                            //         duration: Duration(seconds: 2),
                            //         backgroundColor: Colors.transparent,
                            //         elevation: 0,
                            //       ));
                            //     }
                            //   });
                            // },
                            obscureText: true,
                            textCapitalization: TextCapitalization.sentences,
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
                              password = val;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  //forgot password
                  forgotPassword(),
                  Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: GestureDetector(
                      child: LoginFooterButton(
                          buttonColor: strawberry,
                          textColor: snow,
                          buttonText: 'Log in'),
                      onTap: () {
                        AuthService().signIn(account, password).then((val) {
                          if (val.data['success']) {
                            token = val.data['token'];
                            print(token);
                            AuthService().getUserInfo(token).then((val) {
                              if (val.data['success']) {
                                print('successful get info');
                                print(val.data['body']);
                              }
                            });
                            //Temporary Sign In validation test
                            // print('${account}, ${password}');
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Padding(
                            //     padding: const EdgeInsets.only(bottom: 320.0),
                            //     child: successfulSignInTemp(),
                            //   ),
                            //   behavior: SnackBarBehavior.floating,
                            //   duration: Duration(seconds: 2),
                            //   backgroundColor: Colors.transparent,
                            //   elevation: 0,
                            // ));

                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => MainPage()));
                          }
                        });
                      },
                    ),
                  ),
                  orDivider(),
                  signInPartners()
                ],
              ),
            ),
          )),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }
}

//Sign In Header
Widget typeFace() {
  return Padding(
    padding: EdgeInsets.zero,
    child: Hero(
      transitionOnUserGestures: true,
      tag: 'typeface',
      child: Container(
          height: 140,
          width: 190,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
              "assets/images/Typeface.png",
            ),
          ))),
    ),
  );
}

//TextInput Username/Email/Phone
Widget textInputUsername() {
  return Container(
    width: 326,
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
              color: jetBlack40,
            )),
          ),
        ),
        Expanded(
          child: TextFormField(
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                  overflow: TextOverflow.fade,
                  fontFamily: 'SFDisplay',
                  color: jetBlack80,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: 'Username / Email / Phone',
                hintStyle: const TextStyle(
                  fontFamily: 'SFDisplay',
                  color: shark,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onChanged: (val) {
                account = val;
                print('I am not null');
              }),
        ),
      ],
    ),
  );
}

//TextInput Password
Widget textInputPassword() {
  return Container(
    width: 326,
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
            padding: const EdgeInsets.only(left: 21, right: 12),
            child: Center(
                child: SvgPicture.asset(
              'assets/icons/generalIcons/lock.svg',
              color: jetBlack40,
            )),
          ),
        ),
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.done,
            obscureText: true,
            textCapitalization: TextCapitalization.sentences,
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
      ],
    ),
  );
}

//Forgot Passowrd?
Widget forgotPassword() {
  return Padding(
    padding: const EdgeInsets.only(top: 15, left: 200),
    child: GestureDetector(
      child: Text(
        'Forgot password?',
        style: TextStyle(
          fontFamily: 'SFDisplay',
          color: jetBlack40,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        print('Forgot Password Selected');
      },
    ),
  );
}

Widget orDivider() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Text(
        'or',
        style: TextStyle(
          fontFamily: 'SFDisplay',
          color: jetBlack40,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

//Login with sign-in partners
Widget signInPartners() {
  return Padding(
    padding: const EdgeInsets.only(top: 25.0),
    child: Column(
      children: [
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: SvgPicture.asset(
                  'assets/icons/externalCompanyIcons/Apple.svg',
                  color: jetBlack,
                ),
              ),
              Text(
                'Continue with Apple',
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          //This stuff should work once we set up and pay for an Apple Developer Account ( Not sure 100% why this isnt working, getting an error 1000 || Auth error )

          // onTap: () async {
          //   final credential = await SignInWithApple.getAppleIDCredential(
          //     scopes: [
          //       AppleIDAuthorizationScopes.email,
          //       AppleIDAuthorizationScopes.fullName,
          //     ],
          //   );

          //   print(credential);

          //   // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
          //   // after they have been validated with Apple (see `Integration` section for more information on how to do this)
          // },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: SvgPicture.asset(
                    'assets/icons/externalCompanyIcons/Google.svg'),
              ),
              Text(
                'Continue with Google',
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack40,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget successfulSignInTemp() {
  return Container(
    height: 50,
    width: 323,
    decoration: BoxDecoration(
        color: snow,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: jetBlack.withOpacity(0.01),
            spreadRadius: 0,
            blurRadius: 38,
            offset: Offset(0, 24), // changes position of shadow
          ),
          BoxShadow(
            color: jetBlack.withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 46,
            offset: Offset(0, 9), // changes position of shadow
          ),
          BoxShadow(
            color: jetBlack.withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 11), // changes position of shadow
          ),
        ]),
    child: Center(
        child: Text(
      'Successful login 😁',
      style: TextStyle(
          color: strawberry,
          fontSize: 15,
          fontFamily: 'SFDisplay',
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600),
    )),
  );
}

Widget unsuccessfulSignInTemp() {
  return Container(
    height: 50,
    width: 323,
    decoration: BoxDecoration(
        color: snow,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: jetBlack.withOpacity(0.01),
            spreadRadius: 0,
            blurRadius: 38,
            offset: Offset(0, 24), // changes position of shadow
          ),
          BoxShadow(
            color: jetBlack.withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 46,
            offset: Offset(0, 9), // changes position of shadow
          ),
          BoxShadow(
            color: jetBlack.withOpacity(0.10),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 11), // changes position of shadow
          ),
        ]),
    child: Center(
        child: Text(
      'Incorrect username or password  👀 ',
      style: TextStyle(
          color: Color(0xff7A7D81),
          fontSize: 15,
          fontFamily: 'SFDisplay',
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600),
    )),
  );
}
