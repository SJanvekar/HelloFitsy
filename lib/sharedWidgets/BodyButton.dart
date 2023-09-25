// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BodyButton extends StatelessWidget {
  Color buttonColor;
  Color textColor;
  String buttonText;

  BodyButton(
      {Key? key,
      required this.buttonColor,
      required this.textColor,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Text(
        buttonText,
        style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none),
      )),
    );
  }
}
