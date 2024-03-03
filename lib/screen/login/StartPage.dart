// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:balance/constants.dart';
import 'package:balance/screen/login/components/TrainerOrTrainee.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/screen/login/components/SignIn.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  Artboard? riveArtBoard;
  late Animation<double> _animation;
  late AnimationController _titleSlideAnimationController;
  late Timer _timer1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load('assets/images/fitsy_v1-2.riv').then((data) async {
      try {
        final file = RiveFile.import(data);
        final artBoard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artBoard, 'fitsy');
        if (controller != null) {
          artBoard.addController(controller);
        }
        setState(() {
          riveArtBoard = artBoard;
        });
      } catch (e) {
        print(e);
      }
    });
    _titleSlideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: _titleSlideAnimationController,
      curve:
          Curves.fastEaseInToSlowEaseOut, // You can use different curves here
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _timer1 = Timer(
      const Duration(milliseconds: 1500),
      () => setState(() {
        _titleSlideAnimationController.forward();
      }),
    );
  }

  @override
  void dispose() {
    _titleSlideAnimationController.dispose();
    _timer1.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: snow,
      child: Column(
        children: <Widget>[
          Spacer(),
          if (riveArtBoard != null)
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Center(
                  child: SizedBox(
                height: 200,
                width: 300,
                child: RiveAnimation.asset('assets/images/fitsy_v1-2.riv'),
              )

                  // Container(
                  //   padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  //   decoration: BoxDecoration(
                  //       color: strawberry, borderRadius: BorderRadius.circular(20)),
                  //   child:
                  //   Image.asset(
                  //     'assets/images/Typeface.png',
                  //     height: 80,
                  //     color: snow,
                  //   ),
                  // ),
                  ),
            ),
          Spacer(),
          SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                .animate(
              _animation,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: FooterButton(
                        buttonColor: strawberry,
                        textColor: snow,
                        buttonText: "Start training"),
                    onTap: () {
                      print("Start Training Button Pressed");
                      Navigator.of(context).push(CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => TrainerOrTrainee()));
                    },
                  ),
                  //Sign Up if you don't have an account
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontFamily: 'SFDisplay',
                            color: jetBlack60,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Sign in',
                                style: TextStyle(
                                    fontFamily: 'SFDisplay',
                                    color: ocean,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            fullscreenDialog: false,
                                            builder: (context) => SignIn()));
                                  })
                          ],
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  fullscreenDialog: false,
                                  builder: (context) => SignIn()));
                            }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
