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

class ClassCardOpen extends StatelessWidget {
  const ClassCardOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Hides the top status bar for iOS & Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    //Shows the top status bar for iOS & Android
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: snow,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(slivers: [
        //App Bar
        SliverAppBar(
          toolbarHeight: 65,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/exampleClass.png',
              fit: BoxFit.cover,
            ),
            stretchModes: const [StretchMode.zoomBackground],
          ),
          elevation: 0,
          stretch: true,
          floating: false,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.4,
          backgroundColor: snow,
          shape: Border(
              bottom: BorderSide(color: bone, width: 2)), //Color(0x00000000),
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: GestureDetector(
              child: SvgPicture.asset(
                'assets/icons/ExitButtonClassCard.svg',
                height: 30,
                width: 30,
              ),
              onTap: () => print('Close page prompt'),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/icons/SaveButtonClassCard.svg',
                  height: 36,
                  width: 36,
                ),
                onTap: () => print('Save Button Pressed'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  'assets/icons/ShareButtonClassCard.svg',
                  height: 36,
                  width: 36,
                ),
                onTap: () => print('Share Button Pressed'),
              ),
            ),
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          classTitle(),
          classSubHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: classPrice(),
          ),
          Padding(
              padding: EdgeInsets.only(left: 26.0, top: 20, bottom: 20),
              child: UserProfileComponent()),
          PageDivider(),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: classDesc(),
          ),
          PageDivider(),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: classCategories(),
          ),
          PageDivider(),
          Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: classReviews())
        ])),
      ]),
      //Bottom Navigation Bar
      bottomNavigationBar: Container(
          height: 110,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(color: bone, width: 1),
          )),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 14,
              bottom: 46,
            ),
            child: LoginFooterButton(
              buttonColor: strawberry,
              buttonText: 'Inquire',
              textColor: snow,
            ),
          )),
    );
  }
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

//Price Container
Widget classPrice() {
  return Padding(
    padding: const EdgeInsets.only(left: 26.0),
    child: Container(
        color: snow,
        child: Row(
          children: [
            Text(
              "\u0024300",
              style: TextStyle(
                  color: strawberry,
                  fontSize: 32,
                  fontFamily: 'SFRounded',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -1),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(' /session',
                  style: TextStyle(
                      color: shark,
                      fontFamily: 'SFDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            )
          ],
        )),
  );
}

//Class Type and Title
Widget classTitle() {
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
                left: 26,
                bottom: 2,
              ),
              child: Text(
                'One-on-one training',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: jetBlack40,
                    fontFamily: 'SFDisplay'),
                maxLines: 1,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 26,
                  bottom: 2,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 52,
                    minHeight: 26,
                    maxWidth: 323,
                    minWidth: 323,
                  ),
                  child: AutoSizeText(
                    'Youth Tennis Fundraiser Program',
                    minFontSize: 22,
                    style: TextStyle(
                      fontSize: 31,
                      fontFamily: 'SFDisplay',
                      fontWeight: FontWeight.w600,
                      color: jetBlack,
                    ),
                    maxLines: 2,
                  ),
                ))
          ]));
}

//Class Location
Widget classSubHeader() {
  return Padding(
    padding: const EdgeInsets.only(left: 26.0),
    child: Container(
      color: snow,
      child: Row(
        children: [
          Text(
            'Toronto, Ontario',
            style: TextStyle(
                color: jetBlack,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'SFDisplay'),
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: SvgPicture.asset(
                'assets/icons/CircleDivider.svg',
                height: 4,
                width: 4,
              )),
          trainerRating(),
        ],
      ),
    ),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: snow,
                  fontFamily: 'SFRounded'),
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
              fontSize: 15,
              fontFamily: 'SFRounded',
              fontWeight: FontWeight.w600,
              letterSpacing: 0),
        ),
      )
    ],
  );
}

// //Class Date
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

//Class Desc
Widget classDesc() {
  return Padding(
    padding: const EdgeInsets.only(left: 26, right: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text('About this class',
              style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
        ),
        Container(
          width: 323,
          child: Text(
            'This is an introductory course teaching the fundamental skills of tennis. Focus includes: basic strokes; strategy; rules; scoring; etiquette; practice drills; singles and doubles play. The more experienced students will receive instruction on use of spin; court positioning; footwork; and advanced strategies.',
            style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack60,
                fontSize: 16.5,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

//Class Categories
Widget classCategories() {
  return Padding(
    padding: const EdgeInsets.only(left: 26, right: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text('Related Categories',
              style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CategorySmall(),
        ),
      ],
    ),
  );
}

//Class Reviews
Widget classReviews() {
  return Padding(
    padding: const EdgeInsets.only(left: 26, right: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 202),
                child: Text('Reviews',
                    style: TextStyle(
                        fontFamily: 'SFDisplay',
                        color: jetBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Text('View all',
                        style: TextStyle(
                            fontFamily: 'SFDisplay',
                            color: shark,
                            fontSize: 17,
                            fontWeight: FontWeight.w600)),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 6.0),
                    //   child: SvgPicture.asset('assets/icons/rightChevron.svg'),
                    // )
                  ],
                ),
                onTap: () => print('View all Reviews Button Pressed)'),
              )
            ],
          ),
        ),
        ReviewCard(),
      ],
    ),
  );
}
