import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileComponent extends StatelessWidget {
  const UserProfileComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: const [
            CircleAvatar(
              radius: 28,
              backgroundImage:
                  AssetImage('assets/images/profilePictureDefault.png'),
              backgroundColor: snow,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Text(
                'Test Trainer',
                style: TextStyle(
                    color: jetBlack,
                    fontFamily: 'SFDisplay',
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              Text('@Username',
                  style: TextStyle(
                      color: jetBlack40,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500))
            ],
          ),
        )
      ],
    );
  }
}
