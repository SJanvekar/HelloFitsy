import 'package:balance/sharedWidgets/classes/classListHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowingFeed extends StatelessWidget {
  const FollowingFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ClassListHome());
  }
}
