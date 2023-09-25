import 'dart:convert';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/ForgotPassword.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/fitsySharedLogic/StripeLogic.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../Main.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

var account, password, token;

FocusNode userNameFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();

//---------------Functions-----------------

//Submit Sign In
void onSubmitSignInField(context) {
  AuthService().signIn(account, password).then((val) {
    if (val?.data['success'] ?? false) {
      print('Successful authenticate');
      token = val.data['token'];
      AuthService().getUserInfo(token, account).then((val) async {
        final sharedPrefs = await SharedPreferences.getInstance();
        if (val?.data['success'] ?? false) {
          //Clear shared prefs:
          sharedPrefs.clear();
          await sharedPrefs.setString(
              'loggedUser', jsonEncode(val.data['user']));
          if (val.data['stripeAccountID'] != null)
            sharedPrefs.setString(
                'stripeAccountID', val.data['stripeAccountID'] ?? '');
        } else {
          print('Failed get user info');
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainPage()));
      });
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: Duration(milliseconds: 1500),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.5,
              left: 70.0,
              right: 70.0),
          content: Container(
            height: 35,
            decoration: BoxDecoration(
                color: strawberry,
                borderRadius: BorderRadius.circular(15),
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
              'Incorrect username or password ',
              style: TextStyle(
                  color: snow,
                  fontSize: 16,
                  fontFamily: 'SFDisplay',
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400),
            )),
          )));
    }
  });
}

//---------------Widgets-----------------

//TextInput Username/Email/Phone
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
              width: 18,
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
              // ignore: prefer_const_constructors
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
                account = val;
              }),
        ),
      ],
    ),
  );
}

//Forgot Passowrd?
Widget forgotPassword() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(),
      const Padding(
        padding: EdgeInsets.only(
          top: 15,
        ),
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontFamily: 'SFDisplay',
            color: jetBlack40,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

//Or Divider
Widget orDivider() {
  return Padding(
    padding: const EdgeInsets.only(top: 25.0),
    child: Row(
      children: [
        Expanded(child: PageDivider(leftPadding: 0, rightPadding: 10.0)),
        Text(
          'OR',
          style: TextStyle(
            fontFamily: 'SFDisplay',
            color: jetBlack40,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(child: PageDivider(leftPadding: 10.0, rightPadding: 0)),
      ],
    ),
  );
}

//Sign-in partners
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
          onTap: () async {
            final credential = await SignInWithApple.getAppleIDCredential(
              scopes: [
                AppleIDAuthorizationScopes.email,
                AppleIDAuthorizationScopes.fullName,
              ],
            );

            print(credential);

            // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
            // after they have been validated with Apple (see `Integration` section for more information on how to do this)
          },
        ),

        //DEPRECATED (FOR NOW) --------------------------- // GOOGLE SIGN IN //

        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(right: 11),
        //         child: SvgPicture.asset(
        //           'assets/icons/externalCompanyIcons/Google.svg',
        //         ),
        //       ),
        //       Text(
        //         'Continue with Google',
        //         style: TextStyle(
        //           fontFamily: 'SFDisplay',
        //           color: jetBlack40,
        //           fontSize: 15,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    ),
  );
}

//Sign In Typeface
Widget typeFace(topPadding) {
  return Padding(
    padding: EdgeInsets.only(top: topPadding),
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
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    typeFace(MediaQuery.of(context).size.height * 0.08),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: textInputUsername(),
                    ),
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
                              padding:
                                  const EdgeInsets.only(left: 21, right: 12),
                              child: Center(
                                  child: SvgPicture.asset(
                                'assets/icons/generalIcons/lock.svg',
                                color: jetBlack40,
                                width: 18,
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
                                  color: shark,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              focusNode: passwordFocusNode,
                              onChanged: (val) {
                                password = val;
                              },
                              onSubmitted: (value) {
                                onSubmitSignInField(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TextInput Password

                    //forgot password
                    GestureDetector(
                      child: forgotPassword(),
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => ForgotPasswordPage()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 35.0,
                      ),
                      child: GestureDetector(
                        child: FooterButton(
                            buttonColor: strawberry,
                            textColor: snow,
                            buttonText: 'Log in'),
                        onTap: () {
                          onSubmitSignInField(context);
                        },
                      ),
                    ),
                    orDivider(),

                    //Sign in partners widget
                    signInPartners(),

                    //Sign Up if you don't have an account
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              fontFamily: 'SFDisplay',
                              color: jetBlack40,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(
                                      fontFamily: 'SFDisplay',
                                      color: ocean,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              fullscreenDialog: false,
                                              builder: (context) =>
                                                  PersonalInfo()));
                                    })
                            ],
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    fullscreenDialog: false,
                                    builder: (context) => PersonalInfo()));
                              }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
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
}
