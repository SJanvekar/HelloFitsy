import 'dart:math';

import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileComponent extends StatelessWidget {
  UserProfileComponent(
      {Key? key, required this.userFullName, required this.userName})
      : super(key: key);

  String userFullName;
  String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.5,
          // backgroundImage:
          //     AssetImage('assets/images/profilePictureDefault.png'),
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
          child: Text(
            userFullName[0],
            style: TextStyle(
                color: snow,
                fontFamily: 'SFRounded',
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              Text(userName,
                  style: TextStyle(
                      color: shark,
                      fontFamily: 'SFDisplay',
                      fontSize: 13,
                      fontWeight: FontWeight.w500))
            ],
          ),
        )
      ],
    );
  }
}
