import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/classCardOpen.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import '../../../sharedWidgets/userProfileComponentLight.dart';
import 'package:balance/feModels/classModel.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class HomeClassItem extends StatefulWidget {
  HomeClassItem({
    Key? key,
    required this.classTrainer,
    required this.trainerFirstName,
    required this.trainerLastName,
    required this.classType,
    required this.className,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classWhatYouWillNeed,
    required this.classLocation,
    required this.classPrice,
    required this.classLiked,
    required this.classImage,
    required this.trainerImageUrl,
    required this.classRating,
    required this.classReviews,
  }) : super(key: key);

  String classTrainer;
  String trainerFirstName;
  String trainerLastName;
  ClassType classType;
  String className;
  String classDescription;
  String classWhatToExpect;
  String classWhatYouWillNeed;
  String classLocation;
  double classPrice;
  bool classLiked;
  String classImage;
  String trainerImageUrl;
  double classRating;
  int classReviews;

  //------Functions------//

  //Class Type Function
  var classTypeIconPath = 'assets/icons/generalIcons/classOneOnOne.svg';

  void classTypeIcon(classType) {
    switch (classType) {
      case ClassType.Solo:
        {
          var classTypeIconPath = 'assets/icons/generalIcons/classOneOnOne.svg';
          break;
        }
      case ClassType.Group:
        {
          var classTypeIconPath = 'assets/icons/generalIcons/classGroup.svg';
          break;
        }
      case ClassType.Virtual:
        {
          var classTypeIconPath = 'assets/icons/generalIcons/classVirtual.svg';
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
  //Update this with a count of reviews for the class being viewed
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
  Widget closedContainer(titleBoxWidth) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.classImage,
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
              classTitle(widget.className, titleBoxWidth),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: classSubHeader(widget.classLocation),
              ),
              classPrice(widget.classPrice)
            ],
          ),
        ),

        //Highly Rated Badge
        //Only shows the highly rated badge if the class is rated higher than 4.7/5 stars
        if (widget.classRatingTemp > 4.7) Positioned(child: highlyRatedBadge()),

        //Like Class
        Positioned(
          top: 25,
          right: 25,
          child: GestureDetector(
            child: Column(
              children: [
                Icon(
                  widget.classLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: widget.classLiked ? strawberry : snow,
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
                widget.classLiked = !widget.classLiked;
                HapticFeedback.mediumImpact();
              });
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
        left: 20.0,
        right: 20.0,
        top: 25,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserProfileComponentLight(
                  userFullName:
                      widget.trainerFirstName + ' ' + widget.trainerLastName,
                  userName: widget.classTrainer,
                  imageURL: widget.trainerImageUrl,
                  profileImageRadius: 22.5,
                  userFullNameFontSize: 15,
                  userNameFontSize: 14,
                  userFirstName: widget.trainerFirstName),
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
              transitionDuration: const Duration(milliseconds: 450),
              openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              openElevation: 0,
              closedElevation: 0,
              openBuilder: (BuildContext context, _) => ClassCardOpen(
                classImage: widget.classImage,
                classLiked: widget.classLiked,
                classLocation: widget.classLocation,
                classType: widget.classType,
                className: widget.className,
                classPrice: widget.classPrice,
                classTrainer: widget.classTrainer,
                trainerFirstName: widget.trainerFirstName,
                trainerLastName: widget.trainerLastName,
                trainerImageUrl: widget.trainerImageUrl,
                classRating: widget.classRating,
                classReviews: widget.classReviews,
                classDescription: widget.classDescription,
                classWhatToExpect: widget.classWhatToExpect,
                classWhatYouWillNeed: widget.classWhatYouWillNeed,
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
