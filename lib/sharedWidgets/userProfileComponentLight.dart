import 'dart:math';

import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileComponentLight extends StatelessWidget {
  UserProfileComponentLight({
    Key? key,
    required this.userFullName,
    required this.userFullNameFontSize,
    required this.userName,
    required this.userNameFontSize,
    required this.imageURL,
    required this.profileImageRadius,
  }) : super(key: key);

  String userFullName;
  double userFullNameFontSize;
  String userName;
  double userNameFontSize;
  String imageURL;
  double profileImageRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundImage: NetworkImage(imageURL),
          backgroundColor: Colors.transparent,
          radius: profileImageRadius,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userFullName,
                style: TextStyle(
                    color: jetBlack,
                    fontFamily: 'SFDisplay',
                    fontSize: userFullNameFontSize,
                    fontWeight: FontWeight.w600),
              ),
              Text('@' + userName,
                  style: TextStyle(
                      color: jetBlack40,
                      fontFamily: 'SFDisplay',
                      fontSize: userNameFontSize,
                      fontWeight: FontWeight.w500))
            ],
          ),
        )
      ],
    );
  }
}
