// ignore_for_file: file_names, prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:balance/sharedWidgets/userProfile.dart';
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
      body: CustomScrollView(shrinkWrap: false, slivers: [
        // SliverPersistentHeader(
        //   delegate: MySliverAppBar(expandedHeight: 375),
        //   pinned: true,
        // ),
        //App Bar
        SliverAppBar(
          // title: Text('Salman Janvekar',
          //     style: TextStyle(
          //         color: jetBlack,
          //         fontFamily: 'SFDisplay',
          //         fontWeight: FontWeight.w600,
          //         fontSize: 22.0)),

          toolbarHeight: 65,

          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/theBOY.JPG',
              fit: BoxFit.cover,
            ),
            title: userTitleCard(),
            centerTitle: true,
          ),
          elevation: 0,
          onStretchTrigger: _changeTitleColor(),
          stretch: false,
          floating: false,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.45,
          backgroundColor: snow,

          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(0),
          //   child: Container(
          //     height: 40,
          //     decoration: BoxDecoration(
          //         color: snow,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(20),
          //           topRight: Radius.circular(20),
          //         )),
          //   ),
          // ),
        ),

        ListDataTest()
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

//Sliver List test
Widget ListDataTest() {
  return SliverList(
      delegate: SliverChildListDelegate([
    Padding(
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 26.0, right: 26.0),
        child: UserProfileComponent()),
    PageDivider(),
    Padding(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 26.0, right: 26.0),
      child: classDesc(),
    ),
    PageDivider(),
    Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 20.0, left: 26.0, right: 26.0),
      child: classCategories(),
    ),
    PageDivider(),
    Padding(
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 26.0, right: 26.0),
        child: classReviews())
  ]));
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

//Class Desc
Widget classDesc() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text('About this class',
            style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
      Text(
        'This is an introductory course teaching the fundamental skills of tennis. Focus includes: basic strokes; strategy; rules; scoring; etiquette; practice drills; singles and doubles play. The more experienced students will receive instruction on use of spin; court positioning; footwork; and advanced strategies.',
        style: TextStyle(
            fontFamily: 'SFDisplay',
            color: jetBlack60,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    ],
  );
}

//Class Categories
Widget classCategories() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Text('Related Categories',
            style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: CategorySmall(),
      ),
    ],
  );
}

//Class Reviews
Widget classReviews() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Reviews',
                style: TextStyle(
                    fontFamily: 'SFDisplay',
                    color: jetBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('View all',
                    style: TextStyle(
                        fontFamily: 'SFDisplay',
                        color: shark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),
              onTap: () => print('View all Reviews Button Pressed'),
            )
          ],
        ),
      ),
      ReviewCard(),
    ],
  );
}

//Persistent Header Private Class
class _TitleSliverDelegate extends SliverPersistentHeaderDelegate {
  final String _classType;
  final String _classTitle;

  _TitleSliverDelegate(this._classType, this._classTitle);

  @override
  Widget build(
      BuildContext context, double shrjetBlackOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          color: snow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 0,
                left: 20,
                bottom: 2,
              ),
              child: Text(
                _classType,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: jetBlack40,
                    letterSpacing: -0.75),
                maxLines: 1,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 52,
                    minHeight: 26,
                    maxWidth: 335,
                    minWidth: 335,
                  ),
                  child: AutoSizeText(
                    _classTitle,
                    minFontSize: 18,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: jetBlack,
                        letterSpacing: -0.75),
                    maxLines: 2,
                  ),
                )),
          ],
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 74;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}

//Class Date

// Widget classDate() {
//   return Padding(
//     padding: const EdgeInsets.only(left: 20.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//           text: TextSpan(children: [
//             //Month
//             TextSpan(
//                 text: 'May ',
//                 style: TextStyle(
//                   fontFamily: 'SFDisplay',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                   color: jetBlack,
//                 )),
//             //Date
//             TextSpan(
//                 text: '22nd',
//                 style: TextStyle(
//                   fontFamily: 'SFDisplay',
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: jetBlack,
//                 ))
//           ]),
//         ),
//         Text(
//           '2022',
//           style: TextStyle(
//             fontFamily: 'SFDisplay',
//             fontSize: 24,
//             fontWeight: FontWeight.w200,
//             color: jetBlack,
//           ),
//         )
//       ],
//     ),
//   );
// }


