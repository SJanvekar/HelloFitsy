// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/example.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/login/components/CategorySelection.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
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
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.close_rounded,
                      color: jetBlack80,
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),

          //Body
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - (26 * 2),
                  child: Row(
                    children: [
                      pageTitle(),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - (26 * 2),
                  child: Row(
                    children: [
                      pageText(),
                    ],
                  ),
                ),
              ),

              // Trainer or Trainee selection
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    //Trainer
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.04,
                          bottom: 20),
                      child: GestureDetector(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: userTemplate.userType == UserType.Trainer
                              ? 250
                              : 180,
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
                                  color:
                                      userTemplate.userType == UserType.Trainer
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

                    //Trainee
                    GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: userTemplate.userType == UserType.Trainee
                            ? 250
                            : 180,
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
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 45, left: 26.0, right: 26.0),
            child: GestureDetector(
              child: Hero(
                tag: 'Bottom',
                child: FooterButton(
                  buttonColor: strawberry,
                  textColor: snow,
                  buttonText: "Continue",
                ),
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

  //Page Title
  Widget pageTitle() {
    return Container(
        width: MediaQuery.of(context).size.width - (26 * 2),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Which of the following describes you best?',
          style: logInPageTitleH2,
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }

//Page Title
  Widget pageText() {
    return Container(
        width: MediaQuery.of(context).size.width - (26 * 2),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Select one of the following to help us personalize your in-app experience',
          style: logInPageBodyText,
          textAlign: TextAlign.left,
          softWrap: true,
        ));
  }
}
