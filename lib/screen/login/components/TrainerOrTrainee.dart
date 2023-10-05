// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/example.dart';
import 'package:balance/feModels/AuthModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
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

var passwordConfirmed;

bool passwordCheck = false;
bool emailValid = false;

class _TrainerOrTraineeState extends State<TrainerOrTrainee> {
  //variables
  double range = 0;
  bool _buttonPressed = false;
  // final passwordController = TextEditingController();
  bool _passwordVisibility = true;
  bool _passwordConfirmVisibility = true;
  Color _currentBorderColorTrainee = strawberry;
  Color _currentIconColorTrainee = snow;
  Color _currentBorderColorTrainer = snow;
  Color _currentIconColorTrainer = jetBlack40;
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
                          fullscreenDialog: true,
                          builder: (context) => Login()));
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

                //Trainer or Trainee selection
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 50),
                      curve: Curves.linear,
                      height: 175,
                      width: 175,
                      decoration: BoxDecoration(
                          color: _currentBorderColorTrainer,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: _currentBorderColorTrainer,
                            width: 3,
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 18,
                              bottom: 11,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/generalIcons/trainer.svg",
                              color: _currentIconColorTrainer,
                              height: 55,
                            ),
                          ),
                          Text('Trainer',
                              style: TextStyle(
                                color: _currentIconColorTrainer,
                                fontFamily: 'SFDisplay',
                                fontSize: 20,
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
                    height: 175,
                    width: 175,
                    decoration: BoxDecoration(
                        color: _currentBorderColorTrainee,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                            color: _currentBorderColorTrainee, width: 3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 18,
                            bottom: 11,
                          ),
                          child: Icon(
                            HelloFitsy.user,
                            color: _currentIconColorTrainee,
                            size: 50,
                          ),
                        ),
                        Text(
                          'Trainee',
                          style: TextStyle(
                              color: _currentIconColorTrainee,
                              fontFamily: 'SFDisplay',
                              fontSize: 20,
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
                    builder: (context) => PersonalInfo(
                        authTemplate: authTemplate,
                        userTemplate: userTemplate)));
              },
            ),
          )),
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

//Page title
  Widget pageTitle() {
    return Center(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.06,
              left: 20,
              right: 20,
              bottom: 50.0),
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Which of the following describes you best?',
            style: logInPageTitleH1,
            textAlign: TextAlign.center,
          )),
    );
  }
}
