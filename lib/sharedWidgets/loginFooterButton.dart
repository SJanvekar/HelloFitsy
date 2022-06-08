// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginFooterButton extends StatelessWidget {
  Color buttonColor;
  Color textColor;
  String buttonText;

  LoginFooterButton(
      {Key? key,
      required this.buttonColor,
      required this.textColor,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.5, right: 24.5),
      child: Container(
        height: 50,
        width: 323,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontFamily: 'SFDisplay',
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
