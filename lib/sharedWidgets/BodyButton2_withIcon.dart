// ignore_for_file: file_names

import 'package:balance/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BodyButtonWithIcon extends StatelessWidget {
  Color buttonColor;
  Color textColor;
  String buttonText;
  IconData buttonIcon;
  Color buttonIconColor;

  BodyButtonWithIcon({
    Key? key,
    required this.buttonColor,
    required this.textColor,
    required this.buttonText,
    required this.buttonIcon,
    required this.buttonIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: buttonColor, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(
              buttonIcon,
              size: 18,
              color: buttonIconColor,
            ),
          ),
          Text(
            buttonText,
            style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
