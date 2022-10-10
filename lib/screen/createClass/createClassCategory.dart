import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassDone.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/categories/categoryListLrg.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class CreateClassCategory extends StatefulWidget {
  const CreateClassCategory({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassCategory> createState() => _CreateClassCategory();
}

class _CreateClassCategory extends State<CreateClassCategory> {
  //variables

  void _ButtonOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => PersonalInfo()));
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                      ),
                      child: TextButton(
                        onPressed: () {
                          print("Back");
                          Navigator.of(context).pop(CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => PersonalInfo()));
                        },
                        child: Text("Back", style: logInPageNavigationButtons),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          pageTitle(),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 26, right: 26, top: 20, bottom: 20),
              child: CategoryListLarge(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45.0),
            child: GestureDetector(
              child: LoginFooterButton(
                  buttonColor: strawberry,
                  textColor: snow,
                  buttonText: 'Continue'),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateClassDone()))
              },
            ),
          ),
        ],
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 46, right: 46, top: 10.0),
      child: Container(
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Select categories that this class falls under',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}

//Persistent Header Searchbar
//Persistent Header Private Class
class _SearchBarSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrjetBlackOffset, bool overlapsContent) {
    // TODO: implement build
    return SearchBar(
      isAutoFocusTrue: true,
      searchBarWidth: 323,
      searchHintText: 'Search',
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 10;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
