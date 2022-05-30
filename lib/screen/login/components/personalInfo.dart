// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

void displayDialog(BuildContext context, String title, String text) => 
    showDialog(
      context: context,
      builder: (context) =>
        AlertDialog(
          title: Text(title),
          content: Text(text)
        ),
    );
    
class _PersonalInfoState extends State<PersonalInfo> {
  
  //variables
  double range = 0;
  bool _buttonPressed = false;
  Color _currentBorderColorTrainee = snow;
  Color _currentIconColorTrainee = jetBlack;
  Color _currentBorderColorTrainer = snow;
  Color _currentIconColorTrainer = jetBlack;

  void _ButtonOnPressed() {
    setState(() {
      // print('trainee pressed');
      // print(_buttonPressed);
      if (_buttonPressed == true) {
        _currentBorderColorTrainer = strawberry;
        _currentIconColorTrainer = snow;
        _currentBorderColorTrainee = snow;
        _currentIconColorTrainee = jetBlack;
      } else {
        _currentBorderColorTrainer = snow;
        _currentIconColorTrainer = jetBlack;
        _currentBorderColorTrainee = strawberry;
        _currentIconColorTrainee = snow;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,

      //AppBar
      appBar: AppBar(
        toolbarHeight: 80,
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
          children: [
            pageTitle(),
            pageText(),

            //Trainer or Trainee selection
            Padding(
              padding: const EdgeInsets.only(
                left: 70.5,
                right: 70.5,
                top: 35,
              ),
              child: Row(
                children: [
                  //Trainer selection
                  Padding(
                    padding: EdgeInsets.only(
                      right: 34,
                    ),
                    child: GestureDetector(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.linear,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            color: _currentBorderColorTrainer,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _currentBorderColorTrainer,
                              width: 3,
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 18,
                                bottom: 11,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/Dumbell.svg",
                                color: _currentIconColorTrainer,
                                height: 28.52,
                                width: 53.86,
                              ),
                            ),
                            Text('Trainer',
                                style: TextStyle(
                                  color: _currentIconColorTrainer,
                                  fontFamily: 'SFDisplay',
                                  fontSize: 17,
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
                        })
                      },
                    ),
                  ),

                  //Trainee selection
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.linear,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: _currentBorderColorTrainee,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _currentBorderColorTrainee, width: 3)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 18,
                              bottom: 11,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/User.svg",
                              color: _currentIconColorTrainee,
                              height: 27.72,
                              width: 32.76,
                            ),
                          ),
                          Text(
                            'Trainee',
                            style: TextStyle(
                                color: _currentIconColorTrainee,
                                fontFamily: 'SFDisplay',
                                fontSize: 17,
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
                      })
                    },
                  )
                ],
              ),
            ),

            //User text input fields
            Padding(
              padding: const EdgeInsets.only(
                top: 40,
                left: 24.5,
              ),
              child: textInputFirstLastName(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: textInputUsername(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: textInputEmail(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
              ),
              child: textInputPasswordAndConfirm(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 35,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Row(
                      children: [
                        Text('Class Search Range',
                            style: TextStyle(
                              fontFamily: 'SFDisplay',
                              color: jetBlack,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SvgPicture.asset(
                            'assets/icons/moreInfo.svg',
                            height: 16,
                            width: 16,
                            color: jetBlack40,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 15.0, right: 15.0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        trackShape: RoundedRectSliderTrackShape(),
                        activeTrackColor: strawberry,
                        inactiveTrackColor: shark,
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                          pressedElevation: 0,
                        ),
                        thumbColor: strawberry,
                        overlayColor: Color(0x00000000),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: strawberry,
                        inactiveTickMarkColor: shark,
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: strawberry,
                        valueIndicatorTextStyle: TextStyle(
                          fontFamily: 'SFRounded',
                          color: snow,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                      child: Slider(
                        value: range,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        label: '${range.round()} km',
                        onChanged: (newRange) {
                          setState(() => range = newRange);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 36.0, bottom: 45),
              child: GestureDetector(
                child: LoginFooterButton(
                  buttonColor: shark,
                  textColor: snow,
                  buttonText: "Continue",
                ),
                onTap: () => {
                  print("Continue button pressed"),
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfilePictureUpload()))
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 35),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Tell us about yourself',
          style: logInPageTitle,
        )),
  );
}

//PageText
Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: const [
          TextSpan(
            text: 'Are you looking to train or learn?',
          )
        ],
      ),
    ),
  );
}

//User First + Last Name input
Widget textInputFirstLastName() {
  return Row(
    children: [
      Container(
        width: 158,
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
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                    overflow: TextOverflow.fade,
                    fontFamily: 'SFDisplay',
                    color: jetBlack80,
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
                decoration: InputDecoration.collapsed(
                  border: InputBorder.none,
                  hintText: 'First Name',
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
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          width: 158,
          height: 50,
          decoration: BoxDecoration(
            color: bone60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
              ),
              Expanded(
                child: TextField(
                  autocorrect: true,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                      overflow: TextOverflow.fade,
                      fontFamily: 'SFDisplay',
                      color: jetBlack80,
                      fontSize: 19,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Last Name',
                    hintStyle: TextStyle(
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
        ),
      ),
    ],
  );
}

//Username
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
            autocorrect: true,
            style: const TextStyle(
                overflow: TextOverflow.fade,
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 19,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Username',
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

//Email
Widget textInputEmail() {
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
              'assets/icons/MailIcon.svg',
              width: 24,
              height: 16,
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
                fontSize: 19,
                fontWeight: FontWeight.w700),
            decoration: InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Email',
              hintStyle: const TextStyle(
                fontFamily: 'SFDisplay',
                color: shark60,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: SvgPicture.asset('assets/icons/moreInfo.svg'))
      ],
    ),
  );
}

//Password 1&2
Widget textInputPasswordAndConfirm() {
  return Column(
    children: [
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
                padding: const EdgeInsets.only(left: 22, right: 10),
                child: Center(
                    child: SvgPicture.asset(
                  'assets/icons/lock.svg',
                  width: 21,
                  height: 25,
                  color: jetBlack40,
                )),
              ),
            ),
            Expanded(
              child: TextField(
                //Toggle this on and off with the guesture detector on the eyeOff icon
                obscureText: true,
                autocorrect: true,
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
            Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),

                //Switch the eyeOff icon to the eye Icon on Tap
                child: SvgPicture.asset('assets/icons/eyeOff.svg'))
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Container(
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
                  padding: const EdgeInsets.only(left: 22, right: 10),
                  child: Center(
                      child: SvgPicture.asset(
                    'assets/icons/lock.svg',
                    width: 21,
                    height: 25,
                    color: jetBlack40,
                  )),
                ),
              ),
              Expanded(
                child: TextField(
                  //Toggle this on and off with the guesture detector on the eyeOff icon
                  obscureText: true,
                  autocorrect: true,
                  style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontFamily: 'SFDisplay',
                      color: jetBlack80,
                      fontSize: 19,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'SFDisplay',
                      color: shark60,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),

                  //Switch the eyeOff icon to the eye Icon on Tap
                  child: SvgPicture.asset('assets/icons/eyeOff.svg'))
            ],
          ),
        ),
      ),
    ],
  );
}
