import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileComponent extends StatelessWidget {
  const UserProfileComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.5,
          backgroundImage:
              AssetImage('assets/images/profilePictureDefault.png'),
          backgroundColor: snow,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Test Trainer',
                style: TextStyle(
                    color: jetBlack,
                    fontFamily: 'SFDisplay',
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text('Username',
                  style: TextStyle(
                      color: shark,
                      fontFamily: 'SFDisplay',
                      fontSize: 14,
                      fontWeight: FontWeight.w500))
            ],
          ),
        )
      ],
    );
  }
}
