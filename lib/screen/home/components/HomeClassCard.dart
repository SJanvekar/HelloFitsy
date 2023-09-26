import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/Requests/ClassLikedRequests.dart';
import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/home/components/ClassCardOpen.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../sharedWidgets/userProfileComponentLight.dart';
import 'package:balance/feModels/ClassModel.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class HomeClassItem extends StatefulWidget {
  HomeClassItem({
    Key? key,
    required this.classItem,
    required this.userInstance,
  }) : super(key: key);

  Class classItem;
  User userInstance;

  //------Functions------//

  //Class Type Function
  var classTypeIconPath = 'assets/icons/generalIcons/classOneOnOne.svg';

  void classTypeIcon(classType) {
    switch (classType) {
      case ClassType.Solo:
        {
          classTypeIconPath = 'assets/icons/generalIcons/classOneOnOne.svg';
          break;
        }
      case ClassType.Group:
        {
          classTypeIconPath = 'assets/icons/generalIcons/classGroup.svg';
          break;
        }
      case ClassType.Virtual:
        {
          classTypeIconPath = 'assets/icons/generalIcons/classVirtual.svg';
          break;
        }

      default:
    }
  }

  //This is a initalizer to test the highly rated badge on a class, this will need to be updated with actual values from the backend.
  double classRatingTemp = 4.8;

  @override
  State<HomeClassItem> createState() => _HomeClassItem();
}

//------Widgets------//

//Class reviews
Widget classReviews() {
  ///HARD CODED - MUST CHANGE
  return Text(
    '45 Reviews',
    style: roundedNumberStyle1LightShadowUnderlined,
  );
}

Widget highlyRatedBadge() {
  return Container(
    height: 35,
    width: 110,
    decoration: const BoxDecoration(
        color: sunflower,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 5.0,
            color: jetBlack20,
          )
        ]),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: Icon(
            Icons.stars_rounded,
            color: snow,
            size: 20,
          ),
        ),
        Text(
          'Highly Rated',
          style: roundedBodyTextStyle1,
        )
      ],
    ),
  );
}

class _HomeClassItem extends State<HomeClassItem> {
  bool classLiked = false;
  String trainerUserID = '';
  String trainerImageURL = '';
  String trainerUsername = '';
  String trainerFirstName = '';
  String trainerLastName = '';
  late User user;

  void getClassTrainerInfo() async {
    UserRequests()
        .getClassTrainerInfo(widget.classItem.classTrainerID)
        .then((val) async {
      if (val.data['success']) {
        trainerUserID = val.data['_id'] ?? '';
        trainerImageURL = val.data['ProfileImageURL'] ?? '';
        trainerUsername = val.data['Username'] ?? '';
        trainerFirstName = val.data['FirstName'] ?? '';
        trainerLastName = val.data['LastName'] ?? '';
      } else {
        print('error getting class trainer info: ${val.data['msg']}');
      }
      setState(() {});
    });
  }

  void getIsLiked() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(sharedPrefs.getString('loggedUser') ?? ''));
    ClassLikedRequests()
        .isLiked(user.userID, widget.classItem.classID)
        .then((val) async {
      if (val.data['success']) {
        classLiked = val.data['result'];
      } else {
        print('error getting class liked: ${val.data['result']}');
      }
      setState(() {});
    });
  }

  void handleLikedPress() async {
    setState(() {});
    EasyDebounce.debounce('likedDebouncer', const Duration(milliseconds: 500),
        () => changeLikedStatus());
  }

  void changeLikedStatus() async {
    ClassLikedRequests()
        .addOrRemoveClassLiked(
            user.userID, widget.classItem.classID, classLiked)
        .then((val) async {
      if (val.data['success']) {
        print('classLiked is ${val.data['liked']}');
      } else {
        print('error ${classLiked ? "adding" : "removing"} class liked');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getClassTrainerInfo();
    getIsLiked();
  }

  Widget closedContainer(titleBoxWidth) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.classItem.classImageUrl,
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 400,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    jetBlack20,
                    jetBlack.withOpacity(0.0),
                    jetBlack.withOpacity(0.2),
                    jetBlack60,
                  ],
                  stops: [
                    0,
                    0.25,
                    0.5,
                    1
                  ])),
          height: 400,
        ),

        //Class Details
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              classReviews(),
              classTitle(widget.classItem.className, titleBoxWidth),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: classSubHeader(widget.classItem.classLocationName),
              ),
              classPrice(widget.classItem.classPrice)
            ],
          ),
        ),

        //Highly Rated Badge
        //Only shows the highly rated badge if the class is rated higher than 4.7/5 stars
        //HARD CODED - MUST CHANGE replace with classOverallRating
        if (5.0 > 4.7) Positioned(child: highlyRatedBadge()),

        //Like Class
        Positioned(
          top: 25,
          right: 25,
          child: GestureDetector(
            child: Column(
              children: [
                Icon(
                  classLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: classLiked ? strawberry : snow,
                  size: 26,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 5.0,
                      color: jetBlack,
                    ),
                  ],
                ),

                //Like Counter -- This needs to be updated
                Text(
                  '105',
                  style: roundedNumberStyle1LightShadow,
                )
              ],
            ),
            onTap: () {
              setState(() {
                classLiked = !classLiked;
                HapticFeedback.mediumImpact();
              });
              handleLikedPress();
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleBoxWidth = MediaQuery.of(context).size.width - (26 * 2) - 40;

    return Padding(
      padding: const EdgeInsets.only(
        left: 26.0,
        right: 26.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserProfileComponentLight(
                userID: trainerUserID,
                userFirstName: trainerFirstName,
                userLastName: trainerLastName,
                userName: trainerUsername,
                profileImageURL: trainerImageURL,
                profileImageRadius: 22.5,
                userFullNameFontSize: 15,
                userNameFontSize: 14,
                userInstance: widget.userInstance,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.more_horiz_rounded,
                        color: jetBlack60,
                        size: 25,
                      ),
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
            padding: const EdgeInsets.only(
              top: 15.0,
              bottom: 10,
            ),
            child: OpenContainer(
              transitionDuration: const Duration(milliseconds: 450),
              openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              openElevation: 0,
              closedElevation: 0,
              openBuilder: (BuildContext context, _) => ClassCardOpen(
                classItem: widget.classItem,
                userInstance: widget.userInstance,
              ),
              closedBuilder: (BuildContext context, VoidCallback openClass) =>
                  GestureDetector(
                      onTap: openClass, child: closedContainer(titleBoxWidth)),
            ),
          ),
        ],
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
  return Container(
    height: 25,
    decoration: const BoxDecoration(
        color: strawberry, borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Row(
        children: [
          Text(
            '\$${oCcy.format(classPrice.round())}',
            style: TextStyle(
              color: snow,
              fontSize: 15,
              fontFamily: 'SFRounded',
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
      ),
    ),
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
