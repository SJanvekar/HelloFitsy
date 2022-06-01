// ignore_for_file: prefer_const_constructors

import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: snow,
        appBar: AppBar(
          toolbarHeight: 80,
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
                textInputPassword(),
                forgotPassword(),
                Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: LoginFooterButton(
                      buttonColor: strawberry,
                      textColor: snow,
                      buttonText: 'Log in'),
                ),
                orDivider(),
                signInPartners()
              ],
            ),
          ),
        ));
  }
}

//Sign In Header
Widget typeFace() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
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
              'assets/icons/UserIcon.svg',
              color: jetBlack40,
            )),
          ),
        ),
        Expanded(
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 19,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Username / Email / Phone',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
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
              'assets/icons/lock.svg',
              color: jetBlack40,
            )),
          ),
        ),
        Expanded(
          child: TextField(
            obscureText: true,
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 19,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Password',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
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
          color: shark,
          fontSize: 15,
          fontWeight: FontWeight.w700,
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
      padding: const EdgeInsets.only(top: 30.0),
      child: Text(
        'Or',
        style: TextStyle(
          fontFamily: 'SFDisplay',
          color: shark,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

//Login with sign-in partners
Widget signInPartners() {
  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Column(
      children: [
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 11),
                child: SvgPicture.asset(
                  'assets/icons/Apple.svg',
                  color: jetBlack,
                ),
              ),
              Text(
                'Continue with Apple',
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: shark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
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
                child: SvgPicture.asset('assets/icons/Google.svg'),
              ),
              Text(
                'Continue with Google',
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: shark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
