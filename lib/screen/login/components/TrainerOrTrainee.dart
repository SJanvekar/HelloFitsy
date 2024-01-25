// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/example.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/login/components/CategorySelection.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import '../../../Constants.dart';
import '../../../feModels/UserModel.dart';

class TrainerOrTrainee extends StatefulWidget {
  TrainerOrTrainee({Key? key}) : super(key: key);

  @override
  State<TrainerOrTrainee> createState() => _TrainerOrTraineeState();
}

Auth authTemplate = Auth(
  userEmail: '',
  userPhone: '',
  password: '',
);

User userTemplate = User(
  isActive: true,
  userType: UserType.Trainee,
  profileImageURL: '',
  firstName: '',
  lastName: '',
  userName: '',
);

class _TrainerOrTraineeState extends State<TrainerOrTrainee> {
  @override
  Widget build(BuildContext context) {
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
            // title: Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(
            //         left: 0,
            //       ),
            //       child: TextButton(
            //         onPressed: () {
            //           print("Cancel");
            //           Navigator.of(context).pop(CupertinoPageRoute(
            //               fullscreenDialog: true,
            //               builder: (context) => Login()));
            //         },
            //         child: Text("Cancel", style: logInPageNavigationButtons),
            //       ),
            //     ),
            //   ],
            // ),
          ),

          //Body
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - (26 * 2),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          lineOne(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: lineTwo(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: lineThree(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: lineFour(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Trainer or Trainee selection
                Column(
                  children: [
                    //Trainer
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: GestureDetector(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: userTemplate.userType == UserType.Trainer
                                ? 175
                                : 130,
                            width: userTemplate.userType == UserType.Trainer
                                ? MediaQuery.of(context).size.width - (26 * 2)
                                : MediaQuery.of(context).size.width - (26 * 3),
                            decoration: BoxDecoration(
                              color: userTemplate.userType == UserType.Trainer
                                  ? strawberry
                                  : bone,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text('I’m a personal trainer',
                                  style: TextStyle(
                                    color: userTemplate.userType ==
                                            UserType.Trainer
                                        ? snow
                                        : jetBlack80,
                                    fontFamily: 'SFDisplay',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                          onTap: () => {
                            setState(() {
                              setState(() {
                                HapticFeedback.mediumImpact();
                                userTemplate.userType = UserType.Trainer;
                              });
                            })
                          },
                        ),
                      ),
                    ),

                    //Trainee
                    GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: userTemplate.userType == UserType.Trainee
                            ? 175
                            : 130,
                        width: userTemplate.userType == UserType.Trainee
                            ? MediaQuery.of(context).size.width - (26 * 2)
                            : MediaQuery.of(context).size.width - (26 * 3),
                        decoration: BoxDecoration(
                          color: userTemplate.userType == UserType.Trainee
                              ? strawberry
                              : bone,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'I want to find a personal trainer',
                            style: TextStyle(
                                color: userTemplate.userType == UserType.Trainee
                                    ? snow
                                    : jetBlack80,
                                fontFamily: 'SFDisplay',
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      onTap: () => {
                        setState(() {
                          HapticFeedback.mediumImpact();
                          userTemplate.userType = UserType.Trainee;
                        })
                      },
                    ),
                  ],
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategorySelection(
                        authTemplate: authTemplate,
                        userTemplate: userTemplate)));
              },
            ),
          )),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

//line One
  Widget lineOne() {
    return Container(
      decoration: BoxDecoration(color: snow),
      child: Text(
        'Hi there!',
        style: logInPageTitleH5Disabled,
        textAlign: TextAlign.left,
      ),
    );
  }

//line two
  Widget lineTwo() {
    return Container(
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Welome to Fitsy 😄',
          style: logInPageTitleH5Disabled,
          textAlign: TextAlign.left,
        ));
  }

  //line three
  Widget lineThree() {
    return Container(
        width: MediaQuery.of(context).size.width - (26 * 2),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'We’re proud of you for taking your first step to taking your fitness to the next level',
          style: logInPageTitleH5Disabled,
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

  //line four
  Widget lineFour() {
    return Container(
        width: MediaQuery.of(context).size.width - (26 * 2),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Let’s get right into it, what would you say describes you best?',
          style: logInPageTitleH3,
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }
}
