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
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/exampleClass.png',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 220,
              ),
            ),
          ),
          classTitle(),
          classSubHeader(),
          classPrice(),
        ],
      ),
    );
  }
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
                padding: EdgeInsets.only(
                  bottom: 0,
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
                    minFontSize: 18,
                    style: TextStyle(
                      fontSize: 18,
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
  return Container(
    color: snow,
    child: Row(
      children: [
        Text(
          'Toronto, Ontario',
          style: TextStyle(
              color: jetBlack,
              fontSize: 13,
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
  );
}

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

Widget classPrice() {
  return Container(
      color: snow,
      child: Row(
        children: [
          Text(
            "\u0024300",
            style: TextStyle(
                color: strawberry,
                fontSize: 20,
                fontFamily: 'SFRounded',
                fontWeight: FontWeight.w600,
                letterSpacing: -1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Text(' /session',
                style: TextStyle(
                    color: jetBlack40,
                    fontFamily: 'SFDisplay',
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ));
}
