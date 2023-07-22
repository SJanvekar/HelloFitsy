import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../../../sharedWidgets/userProfileComponentLight.dart';
import 'package:balance/feModels/ClassModel.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class UserListItem extends StatefulWidget {
  UserListItem({
    Key? key,
    required this.trainerUsername,
    required this.trainerFirstName,
    required this.trainerLastName,
    required this.trainerImageUrl,
  }) : super(key: key);

  String trainerUsername;
  String trainerFirstName;
  String trainerLastName;
  String trainerImageUrl;

  @override
  State<UserListItem> createState() => _UserListItem();
}

class _UserListItem extends State<UserListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 26.0,
        right: 26.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserProfileComponentLight(
                  userLastName: widget.trainerLastName,
                  userName: widget.trainerUsername,
                  imageURL: widget.trainerImageUrl,
                  profileImageRadius: 22.5,
                  userFullNameFontSize: 15,
                  userNameFontSize: 14,
                  userFirstName: widget.trainerFirstName),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.more_horiz_rounded,
                        color: jetBlack60,
                        size: 25,
                      ),
                      Container(
                        height: 40,
                        width: 60,
                        color: Colors.transparent,
                      ),
                    ],
                  ),
                  onTap: () => {
                    showModalBottomSheet(
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return classMoreActions();
                        })
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
