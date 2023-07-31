import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/screen/login/components/CategorySelection.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../Authentication/AuthService.dart';
import '../../../feModels/UserModel.dart';
import '../../home/HomeCopy.dart';

// var image = AssetImage('assets/images/profilePictureDefault.png');
var image;

class SetUpTrainerStripeAccount extends StatefulWidget {
  SetUpTrainerStripeAccount(
      {Key? key, required this.authTemplate, required this.userTemplate})
      : super(key: key);

  final Auth authTemplate;
  final User userTemplate;

  @override
  State<SetUpTrainerStripeAccount> createState() =>
      _SetUpTrainerStripeAccountState();
}

class _SetUpTrainerStripeAccountState extends State<SetUpTrainerStripeAccount> {
  File? profilePictureImage;

  //Send Trainer User Model

  void sendUserModel() {
    userTemplate.likedClasses = <String>[];
    userTemplate.classHistory = <String>[];
    userTemplate.followers = <String>[];
    userTemplate.following = <String>[];

    //Auth Service Call
    AuthService().signUp(authTemplate, userTemplate).then((val) {
      if (val.data['success']) {
        print('Successful user add');
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeTest()));
      } else {
        print("Sign up error: ${val.data}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var topPadding;

    return Scaffold(
      backgroundColor: snow,
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
                  print("Back to Personal Info");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => PersonalInfo()));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: TextButton(
                        onPressed: () {
                          print("Back");
                          Navigator.of(context).pop(CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => PersonalInfo()));
                        },
                        child: Text("Back", style: logInPageNavigationButtons),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.15),
              child: pageTitle(),
            ),
            pageText(),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 50),
              child: Image.asset(
                'assets/images/getPaid.png',
                height: 135,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 52,
                  right: 52,
                  bottom: 20,
                ),
                child: connectWithStripe()),
            skip()
          ],
        ),
      ),
    );
  }
}

Widget pageTitle() {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Get paid with Fitsy',
          style: logInPageTitle,
        )),
  );
}

Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(
      top: 5,
      left: 26.0,
      right: 26.0,
    ),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: [
          TextSpan(
            text:
                'Connect your bank account details to start receiving payouts from your classes',
          )
        ],
      ),
    ),
  );
}

Widget connectWithStripe() {
  return Container(
      decoration: BoxDecoration(
          color: strawberry, borderRadius: BorderRadius.circular(20)),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Set up my payment account',
              style: buttonText2snow,
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 20,
              color: snow,
            )
          ],
        ),
      ));
}

Widget skip() {
  return Text('I\'ll do this later', style: buttonText3Jetblack40);
}
