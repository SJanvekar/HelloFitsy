// ignore_for_file: file_names, prefer_const_constructors

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Color titleColor = Colors.transparent;
  Color _textColor = Colors.transparent;
  late ScrollController _scrollController;
//----------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? jetBlack : Colors.transparent;
        });
      });
  }

//----------
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * 0.4 - kToolbarHeight);
  }

//Title Colour Function
  _changeTitleColor() {
    setState(() {
      Color titleColor = jetBlack;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Hides the top status bar for iOS & Android
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    //Shows the top status bar for iOS & Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: snow,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
          shrinkWrap: false,
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              toolbarHeight: 65,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    Image.asset('assets/images/theBOY.JPG', fit: BoxFit.cover),
                centerTitle: true,
                title: Text('Salman Janvekar',
                    style: TextStyle(
                        color: _textColor,
                        fontFamily: 'SFDisplay',
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0)),
              ),
              elevation: 0,
              onStretchTrigger: _changeTitleColor(),
              stretch: true,
              floating: false,
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.45,
              backgroundColor: snow,
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 26.0, right: 26.0),
                  child: Container(
                    color: jetBlack,
                    height: 200,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack80,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack60,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack40,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack20,
                  height: 200,
                ),
              ),
            ])),
          ]),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight),
          child: Image.asset(
            'assets/images/theBOY.JPG',
            fit: BoxFit.cover,
          ),
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Container(
            decoration: BoxDecoration(color: snow),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 26),
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "Salman Janvekar",
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack,
                fontWeight: FontWeight.w600,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: userTitleCard()),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

//Class Type and Title
Widget userTitleCard() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 26.0,
    ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 2.0,
              right: 20.0,
            ),
            child: Text(
              'Salman Janvekar',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w600,
                color: jetBlack,
              ),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: SvgPicture.asset(
                    'assets/icons/navigationBarIcon/User.svg',
                    color: jetBlack,
                    height: 10,
                  ),
                ),
                Text(
                  'salman',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: jetBlack,
                      fontFamily: 'SFDisplay'),
                  maxLines: 1,
                ),
              ],
            ),
          ),
          // trainerSubHeader(),
        ]),
  );
}

//Class Location
Widget trainerSubHeader() {
  return Row(
    children: [
      Text(
        'Toronto, Ontario',
        style: TextStyle(
            color: snow,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFDisplay'),
      ),
      Padding(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
          ),
          child: SvgPicture.asset('assets/icons/CircleDivider.svg',
              height: 4, width: 4, color: bone)),
      trainerRating(),
    ],
  );
}

//Class Trainer Rating
Widget trainerRating() {
  return Row(
    children: [
      //Star Icon
      SvgPicture.asset(
        'assets/icons/StarRating.svg',
        height: 15,
        width: 15,
      ),

      //Rating (Numeric)
      Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Container(
          height: 20,
          width: 30,
          decoration: BoxDecoration(
              color: jetBlack, borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Text(
              ' 4.5 ',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: snow,
                  fontFamily: 'SFDisplay'),
            ),
          ),
        ),
      ),

      //Trainer Ratings Count
      Padding(
        padding: EdgeInsets.only(left: 5.0),
        child: Text(
          '(479 Reviews)',
          style: TextStyle(
              color: shark,
              fontSize: 14,
              fontFamily: 'SFDisplay',
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
        ),
      )
    ],
  );
}
