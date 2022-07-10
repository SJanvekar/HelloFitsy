import 'dart:ui';

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/categories/categoryListLrg.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({Key? key}) : super(key: key);

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
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
                  print("Back to Personal Info");
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
          pageText(),
          SearchBar(),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 26, right: 26, top: 20, bottom: 45),
              child: CategoryListLarge(),
            ),
          ),
        ],
      ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       title: Column(children: [
      //         pageTitle(),
      //         pageText(),
      //       ]),
      //       automaticallyImplyLeading: false,
      //       backgroundColor: snow,
      //       toolbarHeight: 119,
      //     ),
      //     SliverPersistentHeader(
      //       delegate: _SearchBarSliverDelegate(),
      //       floating: false,
      //     ),
      //     SliverList(delegate: SliverChildListDelegate([])),
      //   ],
      // )
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
          decoration: BoxDecoration(color: snow),
          child: Text(
            'What are your interests?',
            style: logInPageTitle,
          )),
    ),
  );
}

//PageText
Widget pageText() {
  return Padding(
    padding: const EdgeInsets.only(top: 5, bottom: 30, left: 69, right: 69),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: logInPageBodyText,
        children: const [
          TextSpan(
              text: 'Personalize your explore feed with the sports you love',
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: shark,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
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
    return SearchBar();
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
