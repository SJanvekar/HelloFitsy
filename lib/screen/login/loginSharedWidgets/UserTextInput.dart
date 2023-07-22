// ignore_for_file: file_names, must_be_immutable

import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserTextInput extends StatelessWidget {
  String iconPath;
  String placeholderText;
  double? width;
  double? iconContainerWidth = 48;
  bool hasMoreInfoButton;
  bool hasIcon;
  bool textVisible;

  UserTextInput(
      {Key? key,
      this.iconContainerWidth,
      required this.width,
      required this.placeholderText,
      required this.iconPath,
      required this.hasMoreInfoButton,
      required this.hasIcon,
      required this.textVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: bone,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Container(
              width: iconContainerWidth,
              height: 40,
              child: Visibility(
                visible: hasIcon,
                child: Center(
                    child: SvgPicture.asset(
                  iconPath,
                  color: jetBlack40,
                )),
              ),
            ),
          ),
          Expanded(
            child: TextField(
              obscureText: textVisible,
              textCapitalization: TextCapitalization.sentences,
              style: const TextStyle(
                  overflow: TextOverflow.fade,
                  color: jetBlack80,
                  fontSize: 17,
                  fontWeight: FontWeight.w700),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: placeholderText,
                hintStyle: const TextStyle(
                  color: jetBlack40,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          // Text(placeholderText,
          //     style: const TextStyle(
          //       color: ink30,
          //       fontSize: 15,
          //       fontWeight: FontWeight.w700,
          //     ))
        ],
      ),
    );
  }
}
