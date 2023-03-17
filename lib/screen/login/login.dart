// ignore_for_file: prefer_const_constructors

import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/screen/login/components/signIn.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: snow,
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                left: 23.5,
                right: 23.5,
                top: 311,
              ),
              child: Hero(
                  tag: 'typeface',
                  child: Image.asset(
                    'assets/images/Typeface.png',
                    height: 142,
                    width: 195,
                  ))),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: GestureDetector(
                  child: FooterButton(
                      buttonColor: strawberry,
                      textColor: snow,
                      buttonText: "Start training"),
                  onTap: () {
                    print("Start Training Button Pressed");
                    Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => PersonalInfo()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Center(
                child: Container(
                  height: 60,
                  width: 110,
                  child: SizedBox(
                    height: 60,
                    width: 110,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text("Log In",
                            style: TextStyle(
                              fontFamily: 'SFDisplay',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: strawberry,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                print("Sign In Button Pressed");
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) {
                      return SignIn();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
