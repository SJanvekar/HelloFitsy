import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balance/Requests/requests.dart';

import '../../../sharedWidgets/userProfile.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';

class HomeClassItem extends StatefulWidget {
  const HomeClassItem({Key? key}) : super(key: key);

  @override
  State<HomeClassItem> createState() => _HomeClassItem();
}

final allClasses = classList[0];

class _HomeClassItem extends State<HomeClassItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 30, bottom: 20, left: 26.0, right: 26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserProfileComponent(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/Ellipses.svg',
                          color: jetBlack60),
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
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: GestureDetector(
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
              onTap: () {
                print("TAPPED");
                Requests().addClass(
                    allClasses.className,
                    allClasses.classType,
                    allClasses.classLocation,
                    allClasses.classRating,
                    allClasses.classReview,
                    allClasses.classPrice,
                    allClasses.classTrainer,
                    allClasses.classLiked);
              },
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
              allClasses.className,
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
        allClasses.classLocation,
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
        allClasses.classPrice.toString(),
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
              allClasses.classRating.toString(),
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
          allClasses.classReview.toString(),
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
