import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../sharedWidgets/userProfile.dart';

class HomeClassItem extends StatefulWidget {
  const HomeClassItem({Key? key}) : super(key: key);

  @override
  State<HomeClassItem> createState() => _HomeClassItem();
}

class _HomeClassItem extends State<HomeClassItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30, bottom: 20, left: 26.0, right: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserProfileComponent(),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/exampleClass.png',
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 250,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              jetBlack.withOpacity(0.0),
                              jetBlack,
                            ],
                            stops: [
                              0.0,
                              1.0
                            ])),
                    height: 250,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 160.0, left: 20),
                      child: Column(
                        children: [
                          classTitle(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: classSubHeader(),
                          ),
                          classPrice()
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Class Type and Title
Widget classTitle() {
  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: AutoSizeText(
              'Youth Tennis Fundraiser Program WILL XIAN TEST TEST TEST',
              minFontSize: 18,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w600,
                color: snow,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ))
      ]);
}

//Class Location
Widget classSubHeader() {
  return Row(
    children: [
      Text(
        'Toronto, Ontario',
        style: TextStyle(
            color: snow,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: 'SFDisplay'),
      ),
    ],
  );
}

//Price Widget

Widget classPrice() {
  return Row(
    children: [
      Text(
        "\u0024300",
        style: TextStyle(
            color: strawberry,
            fontSize: 20,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w600,
            letterSpacing: -1),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 1.0),
        child: Text(' /session',
            style: TextStyle(
                color: shark,
                fontFamily: 'SFDisplay',
                fontSize: 14,
                fontWeight: FontWeight.w400)),
      )
    ],
  );
}

//Unused Widgets

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
                  fontSize: 11,
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
              fontSize: 13,
              fontFamily: 'SFRounded',
              fontWeight: FontWeight.w500,
              letterSpacing: 0),
        ),
      )
    ],
  );
}
