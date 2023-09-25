import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      body: Center(
          child: LoadingAnimationWidget.discreteCircle(
        color: strawberry,
        secondRingColor: strawberry40,
        thirdRingColor: bone,
        size: 100,
      )),
    );
  }
}
