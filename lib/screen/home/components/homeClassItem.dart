import 'dart:ffi';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/classCardOpen.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../../sharedWidgets/userProfileComponentLight.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';
import 'package:balance/Requests/requests.dart';

import '../../profile/components/profile.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class HomeClassItem extends StatefulWidget {
  HomeClassItem({
    Key? key,
    required this.classTrainer,
    required this.userName,
    required this.classType,
    required this.className,
    required this.classDescription,
    required this.classLocation,
    required this.classPrice,
    required this.classLiked,
    required this.classImage,
    required this.trainerImageUrl,
    required this.classRating,
    required this.classReviews,
  }) : super(key: key);

  String classTrainer;
  String userName;
  ClassType classType;
  String className;
  String classDescription;
  String classLocation;
  double classPrice;
  bool classLiked;
  String classImage;
  String trainerImageUrl;
  double classRating;
  int classReviews;

  var classTypeIconPath = 'assets/icons/generalIcons/classOneOnOne.svg';

  void classTypeIcon(classType) {
    switch (classType) {
      case ClassType.solo:
        {
          var classTypeIconPath = 'assets/icons/generalIcons/classOneOnOne.svg';
          break;
        }
      case ClassType.group:
        {
          var classTypeIconPath = 'assets/icons/generalIcons/classGroup.svg';
          break;
        }
      case ClassType.virtual:
        {
          var classTypeIconPath = 'assets/icons/generalIcons/classVirtual.svg';
          break;
        }

      default:
    }
  }

  @override
  State<HomeClassItem> createState() => _HomeClassItem();
}

class _HomeClassItem extends State<HomeClassItem> {
  @override
  Widget build(BuildContext context) {
    var iconDistance = MediaQuery.of(context).size.width - (26 * 2) - 45;
    final titleBoxWidth = MediaQuery.of(context).size.width - (26 * 2) - 40;

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
                GestureDetector(
                  child: UserProfileComponentLight(
                    userFullName: widget.classTrainer,
                    userName: widget.userName,
                    imageURL: widget.trainerImageUrl,
                    profileImageRadius: 22.5,
                    userFullNameFontSize: 15,
                    userNameFontSize: 14,
                  ),
                  onTap: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        maintainState: true,
                        builder: (context) => UserProfile(
                              profileImageUrl: widget.trainerImageUrl,
                            )));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                            'assets/icons/generalIcons/ellipses.svg',
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
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 10,
              ),
              child: OpenContainer(
                transitionDuration: Duration(milliseconds: 350),
                openShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                openElevation: 0,
                closedElevation: 0,
                openColor: Colors.transparent,
                closedColor: Colors.transparent,
                openBuilder: (BuildContext context, _) => ClassCardOpen(
                  classImage: widget.classImage,
                  classLiked: widget.classLiked,
                  classLocation: widget.classLocation,
                  className: widget.className,
                  classPrice: widget.classPrice,
                  classTrainer: widget.classTrainer,
                  classType: 'One-on-one training',
                  trainerImageUrl: widget.trainerImageUrl,
                  userName: widget.userName,
                  classRating: widget.classRating,
                  classReviews: widget.classReviews,
                  classDescription: widget.classDescription,
                ),
                closedBuilder: (BuildContext context, VoidCallback openClass) =>
                    GestureDetector(
                  onTap: openClass,
                  child: Center(
                    child: Card(
                      color: snow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        // alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
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
                                    ]),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      widget.classImage,
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 350,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      jetBlack20,
                                      jetBlack.withOpacity(0.0),
                                      jetBlack.withOpacity(0.2),
                                      jetBlack,
                                    ],
                                    stops: [
                                      0,
                                      0.25,
                                      0.5,
                                      1
                                    ])),
                            height: 350,
                          ),
                          // Positioned(
                          //     bottom: 20,
                          //     left: 20,
                          //     child:
                          //         classTitle(widget.className, titleBoxWidth)),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                classTitle(widget.className, titleBoxWidth),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2.0),
                                  child: classSubHeader(widget.classLocation),
                                ),
                                classPrice(widget.classPrice)
                              ],
                            ),
                          ),
                          Positioned(
                            top: 25,
                            right: 25,
                            child: Row(
                              children: [
                                GestureDetector(
                                  child: SvgPicture.asset(
                                    widget.classLiked
                                        ? 'assets/icons/generalIcons/favouriteFill.svg'
                                        : 'assets/icons/generalIcons/favouriteEmpty.svg',
                                    color:
                                        widget.classLiked ? strawberry : snow,
                                    height: 20,
                                    width: 20,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Class Type and Title
Widget classTitle(classTitle, fixedWidth) {
  return SizedBox(
    width: fixedWidth,
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
    ),
  );
}

//Class Location
Widget classSubHeader(classLocation) {
  return Text(
    classLocation,
    style: TextStyle(
        color: bone80,
        fontSize: 13.5,
        fontWeight: FontWeight.w500,
        fontFamily: 'SFDisplay'),
  );
}

//Price Widget
Widget classPrice(classPrice) {
  return Row(
    children: [
      Text(
        '\$${oCcy.format(classPrice.round())}',
        style: TextStyle(
          color: strawberry,
          fontSize: 20,
          fontFamily: 'SFDisplay',
          fontWeight: FontWeight.w600,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 1.0),
        child: Text(' /session',
            style: TextStyle(
                color: snow,
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
