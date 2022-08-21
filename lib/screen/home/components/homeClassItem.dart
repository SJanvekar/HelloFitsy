import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import '../../../sharedWidgets/userProfile.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';
import 'package:balance/Requests/requests.dart';

class HomeClassItem extends StatefulWidget {
  HomeClassItem({
    Key? key,
    required this.classTrainer,
    required this.userName,
    required this.className,
    required this.classType,
    required this.classLocation,
    required this.classPrice,
    required this.classLiked,
    required this.classImage,
  }) : super(key: key);

  String classTrainer;
  String userName;
  String className;
  String classType;
  String classLocation;
  int classPrice;
  bool classLiked;
  String classImage;

  @override
  State<HomeClassItem> createState() => _HomeClassItem();
}

class _HomeClassItem extends State<HomeClassItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 26.0,
          right: 26.0,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserProfileComponent(
                  userFullName: widget.classTrainer,
                  userName: widget.userName,
                ),
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
                            return classMoreActions(
                              userFullName: widget.classTrainer,
                            );
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
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  widget.classImage,
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: 220,
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
                        height: 220,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 10),
                          child: Column(
                            children: [
                              classTitle(widget.className),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: classSubHeader(widget.classLocation),
                              ),
                              classPrice(widget.classPrice)
                            ],
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 230, right: 10.0, bottom: 170),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SvgPicture.asset(
                                'assets/icons/classTypeIcons/OneOnOneIcon.svg',
                                height: 32,
                                width: 32,
                              ),
                            ),
                            GestureDetector(
                              child: SvgPicture.asset(
                                widget.classLiked
                                    ? 'assets/icons/SaveButtonClassCardLiked.svg'
                                    : 'assets/icons/SaveButtonClassCard.svg',
                                height: 32,
                                width: 32,
                              ),
                              onTap: () {
                                setState(() {
                                  widget.classLiked = !widget.classLiked;
                                  HapticFeedback.mediumImpact();
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => {print(widget.className)},
    );
  }
}

//Class Type and Title
Widget classTitle(classTitle) {
  return Row(
    children: [
      Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: AutoSizeText(
                    classTitle,
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
            ]),
      ),
    ],
  );
}

//Class Location
Widget classSubHeader(classLocation) {
  return Row(
    children: [
      Text(
        classLocation,
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
Widget classPrice(classPrice) {
  return Row(
    children: [
      Text(
        classPrice.toString(),
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
// Widget trainerRating(classRating, classReview) {
//   return Row(
//     children: [
//       //Star Icon
//       SvgPicture.asset(
//         'assets/icons/StarRating.svg',
//         height: 15,
//         width: 15,
//       ),

//       //Rating (Numeric)
//       Padding(
//         padding: const EdgeInsets.only(left: 5.0),
//         child: Container(
//           height: 20,
//           width: 30,
//           decoration: BoxDecoration(
//               color: jetBlack, borderRadius: BorderRadius.circular(20.0)),
//           child: Center(
//             child: Text(
//               classRating.toString(),
//               style: TextStyle(
//                   fontSize: 11,
//                   fontWeight: FontWeight.w700,
//                   color: snow,
//                   fontFamily: 'SFRounded'),
//             ),
//           ),
//         ),
//       ),

//       //Trainer Ratings Count
//       Padding(
//         padding: EdgeInsets.only(left: 5.0),
//         child: Text(
//          classReview.toString(),
//           style: TextStyle(
//               color: shark,
//               fontSize: 13,
//               fontFamily: 'SFRounded',
//               fontWeight: FontWeight.w500,
//               letterSpacing: 0),
//         ),
//       )
//     ],
//   );
// }
