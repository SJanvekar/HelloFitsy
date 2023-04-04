// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:balance/Requests/userRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/categories.dart';
import 'package:balance/sharedWidgets/bodyButton.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/classes/classItemCondensed1.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../../feModels/classModel.dart';

class EditProfile extends StatefulWidget {
  EditProfile({
    Key? key,
    required this.profileImageUrl,
    required this.newProfileImage,
  }) : super(key: key);

  String? profileImageUrl;
  File? newProfileImage;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    //Shows the top status bar for iOS & Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                print("Cancel");
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: logInPageNavigationButtons),
            ),
            Text(
              'Edit Profile',
              style: sectionTitles,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Done", style: doneTextButton),
            ),
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).copyWith().size.height,
        decoration: BoxDecoration(
          color: snow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomScrollView(
          slivers: [
            MultiSliver(children: [
              Center(
                  child: Stack(
                children: [
                  if (widget.newProfileImage != null)
                    ClipOval(
                        child: Image.file(
                      widget.newProfileImage!,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ))
                  else if (widget.profileImageUrl != null &&
                      widget.newProfileImage == null)
                    ClipOval(
                        child: Image(
                      image: NetworkImage(widget.profileImageUrl!),
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ))
                  else
                    ClipOval(
                        child: Image.asset(
                      'assets/images/profilePictureDefault.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ))
                ],
              )),
              Padding(
                padding: EdgeInsets.only(
                    top: 15.0,
                    left: MediaQuery.of(context).size.width * 0.3,
                    right: MediaQuery.of(context).size.width * 0.3),
                child: BodyButton(
                  buttonColor: strawberry,
                  textColor: snow,
                  buttonText: 'Upload new picture',
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
