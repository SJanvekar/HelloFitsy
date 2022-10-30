import 'package:balance/constants.dart';
import 'package:balance/screen/profile/components/profile.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: snow,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 15.0, top: 90.0),
          child: Column(
            children: [
              UserProfileComponentLight(
                userFullName: 'Salman Janvekar',
                userFullNameFontSize: 17,
                userName: 'salman',
                userNameFontSize: 15.5,
                imageURL:
                    'https://firebasestorage.googleapis.com/v0/b/fitsy-5wx21.appspot.com/o/IMG_9010.jpeg?alt=media&token=3c7a2cfd-831b-4f19-8b23-9328f00aa76f',
                profileImageRadius: 35,
                userFirstName: 'Salman',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 40, top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '150',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' Following',
                          style: TextStyle(
                              color: jetBlack80,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '38',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' Classes taken',
                          style: TextStyle(
                              color: jetBlack80,
                              fontFamily: 'SFDisplay',
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      ListTile(
                        minLeadingWidth: 22,
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                            fullscreenDialog: true,
                            type: PageTransitionType.rightToLeft,
                            child: UserProfile(
                              profileImageUrl:
                                  'https://firebasestorage.googleapis.com/v0/b/fitsy-5wx21.appspot.com/o/IMG_9010.jpeg?alt=media&token=3c7a2cfd-831b-4f19-8b23-9328f00aa76f',
                              userFullName: 'Salman Janvekar',
                              userName: '@salman',
                              userFirstName: 'Salman',
                            ),
                          ));
                        },
                        leading: Container(
                          height: double.infinity,
                          child: SvgPicture.asset(
                            'assets/icons/generalIcons/user.svg',
                            height: 24,
                          ),
                        ),
                        title: Text(
                          'Profile',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        horizontalTitleGap: 20,
                      ),
                      SizedBox(height: 15.0),
                      ListTile(
                        minLeadingWidth: 22,
                        onTap: () => {},
                        leading: Container(
                          height: double.infinity,
                          child: SvgPicture.asset(
                            'assets/icons/generalIcons/favouriteFill.svg',
                            height: 18,
                          ),
                        ),
                        title: Text(
                          'Saved Classes',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        horizontalTitleGap: 20,
                      ),
                      SizedBox(height: 15.0),
                      ListTile(
                        minLeadingWidth: 22,
                        onTap: () => {},
                        leading: Container(
                          height: double.infinity,
                          child: SvgPicture.asset(
                            'assets/icons/generalIcons/classHistory.svg',
                            height: 22,
                          ),
                        ),
                        title: Text(
                          'Class History',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        horizontalTitleGap: 20,
                      ),
                      SizedBox(height: 15.0),
                      ListTile(
                        minLeadingWidth: 22,
                        onTap: () => {},
                        leading: Container(
                          height: double.infinity,
                          child: SvgPicture.asset(
                            'assets/icons/generalIcons/settings.svg',
                            height: 22,
                          ),
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        horizontalTitleGap: 22,
                      ),
                      SizedBox(height: 15.0),
                      ListTile(
                        minLeadingWidth: 22,
                        onTap: () => {},
                        leading: Container(
                          height: double.infinity,
                          child: SvgPicture.asset(
                            'assets/icons/generalIcons/inviteUsers.svg',
                            height: 22,
                          ),
                        ),
                        title: Text(
                          'Invite',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        horizontalTitleGap: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
