import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/ClassCardOpen.dart';
import 'package:balance/sharedWidgets/classMoreActions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../sharedWidgets/userProfileComponentLight.dart';
import 'package:balance/feModels/ClassModel.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ProfileClassCard extends StatefulWidget {
  ProfileClassCard({
    Key? key,
    required this.classTrainer,
    required this.trainerFirstName,
    required this.trainerLastName,
    required this.classType,
    required this.className,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classWhatYouWillNeed,
    required this.classLocationName,
    required this.classPrice,
    required this.classImage,
    required this.trainerImageUrl,
    required this.classRating,
    required this.classReviews,
    required List classTimes,
  }) : super(key: key);

  String classTrainer;
  String trainerFirstName;
  String trainerLastName;
  ClassType classType;
  String className;
  String classDescription;
  String classWhatToExpect;
  String classWhatYouWillNeed;
  String classLocationName;
  double classPrice;
  //HARD CODED - MUST CHANGE
  bool classLiked = false;
  String classImage;
  String trainerImageUrl;
  double classRating;
  int classReviews;

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

  @override
  State<ProfileClassCard> createState() => _ProfileClassCard();
}

class _ProfileClassCard extends State<ProfileClassCard> {
  @override
  Widget build(BuildContext context) {
    var iconDistance = MediaQuery.of(context).size.width - (26 * 2) - 45;
    final titleBoxWidth = MediaQuery.of(context).size.width - (26 * 2) - 40;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: OpenContainer(
        transitionDuration: Duration(milliseconds: 350),
        openShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        openElevation: 0,
        closedElevation: 0,
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        openBuilder: (BuildContext context, _) => ClassCardOpen(
          classImage: widget.classImage,
          classLiked: widget.classLiked,
          classLocationName: widget.classLocationName,
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
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 320,
                    width: 250,
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
                              jetBlack,
                            ],
                            stops: [
                              0,
                              0.25,
                              0.5,
                              1
                            ])),
                    height: 320,
                    width: 250,
                  ),
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
                          child: classSubHeader(widget.classLocationName),
                        ),
                        classPrice(widget.classPrice)
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                            widget.classLiked
                                ? 'assets/icons/generalIcons/favouriteFill.svg'
                                : 'assets/icons/generalIcons/favouriteEmpty.svg',
                            color: widget.classLiked ? strawberry : snow,
                            height: 18,
                            width: 18,
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
    );
  }
}

//Class Type and Title
Widget classTitle(classTitle, fixedWidth) {
  return SizedBox(
    width: fixedWidth,
    child: AutoSizeText(
      classTitle,
      minFontSize: 16,
      style: TextStyle(
        fontSize: 16,
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
        fontSize: 12,
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
          fontSize: 18,
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
                fontSize: 12,
                fontWeight: FontWeight.w400)),
      )
    ],
  );
}
