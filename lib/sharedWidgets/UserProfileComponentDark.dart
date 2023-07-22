import 'dart:ui';
import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/profile/components/Profile.dart';

class UserProfileComponentDark extends StatelessWidget {
  UserProfileComponentDark({
    Key? key,
    required this.userFullName,
    required this.userFirstName,
    required this.userFullNameFontSize,
    required this.userName,
    required this.userNameFontSize,
    required this.imageURL,
    required this.profileImageRadius,
  }) : super(key: key);

  String userFullName;
  String userFirstName;
  double userFullNameFontSize;
  String userName;
  double userNameFontSize;
  String imageURL;
  double profileImageRadius;

  //Follow button ~ State 0
  Widget followButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: new ImageFilter.blur(
          sigmaX: 1,
          sigmaY: 1,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 34,
          width: 90,
          decoration: BoxDecoration(
              color: shark40,
              border: Border.all(color: shark60),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Follow',
            style: TextStyle(
                color: snow,
                fontFamily: 'SFDisplay',
                fontSize: 13.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

//Follow Button ~ state 1 (Following)
  Widget followingButton() {
    return Container(
      alignment: Alignment.center,
      height: 34,
      width: 90,
      decoration: BoxDecoration(
          color: strawberry, borderRadius: BorderRadius.circular(20)),
      child: Text(
        'Following',
        style: TextStyle(
            color: snow,
            fontFamily: 'SFDisplay',
            fontSize: 13.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                          color: snow,
                          fontFamily: 'SFDisplay',
                          fontSize: userFullNameFontSize,
                          fontWeight: FontWeight.w600),
                    ),
                    Text('@' + userName,
                        style: TextStyle(
                            color: bone,
                            fontFamily: 'SFDisplay',
                            fontSize: userNameFontSize,
                            fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            maintainState: true, builder: (context) => UserProfile()));
      },
    );
  }
}
