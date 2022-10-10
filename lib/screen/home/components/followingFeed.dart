import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/classes/classListHome.dart';
import 'package:flutter/material.dart';

class FollowingFeed extends StatelessWidget {
  const FollowingFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(
          'Upcoming Classes',
          style: TextStyle(
            color: jetBlack,
            fontFamily: 'SFDisplay',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        ClassListHome(),
      ],
    ));
  }
}
