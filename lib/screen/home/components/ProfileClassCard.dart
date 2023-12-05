import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:balance/Requests/ClassLikedRequests.dart';
import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/components/ClassCardOpen.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:balance/feModels/ClassModel.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ProfileClassCard extends StatefulWidget {
  ProfileClassCard(
      {Key? key, required this.classItem, required this.userInstance})
      : super(key: key);

  Class classItem;
  User userInstance;

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
  //Vars
  bool classLiked = false;
  String trainerUserID = '';
  String trainerImageURL = '';
  String trainerUsername = '';
  String trainerFirstName = '';
  String trainerLastName = '';
  late User user;

  //Functions

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
        //If this request doesn't work, set liked to false again
        classLiked = false;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getClassTrainerInfo();
    getIsLiked();
  }

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
          classItem: widget.classItem,
          userInstance: widget.userInstance,
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
                              widget.classItem.classImageUrl,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 224,
                            child: Flexible(
                                child: classTitle(widget.classItem.className))),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: classSubHeader(
                              widget.classItem.classLocationName),
                        ),
                        classPrice(widget.classItem.classPrice)
                      ],
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      children: [
                        if (widget.classItem.classTrainerID ==
                            widget.userInstance.userID)
                          GestureDetector(
                            child: Icon(
                              Icons.edit,
                              color: snow,
                              size: 26,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 8.0,
                                  color: jetBlack60,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => CreateClassSelectType(
                                        isTypeSelected: true,
                                        classTemplate: widget.classItem,
                                        isEditMode: true,
                                      )));
                            },
                          )
                        else
                          GestureDetector(
                            child: Icon(
                              classLiked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              color: classLiked ? strawberry : snow,
                              size: 26,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 8.0,
                                  color: jetBlack60,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                classLiked = !classLiked;
                                HapticFeedback.mediumImpact();
                              });
                              handleLikedPress();
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
Widget classTitle(
  classTitle,
) {
  return Text(
    classTitle,
    style: TextStyle(
        fontSize: 16,
        fontFamily: 'SFDisplay',
        fontWeight: FontWeight.w600,
        color: snow,
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0, 0),
            blurRadius: 8.0,
            color: jetBlack80,
          ),
        ]),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

//Class Location
Widget classSubHeader(classLocation) {
  return Text(
    classLocation,
    style: TextStyle(
        color: bone80,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        fontFamily: 'SFDisplay',
        shadows: <Shadow>[
          Shadow(
            offset: Offset(0, 0),
            blurRadius: 8.0,
            color: jetBlack80,
          ),
        ]),
  );
}

//Price Widget
Widget classPrice(classPrice) {
  return Row(
    children: [
      Text(
        '\$${oCcy.format(classPrice.round())}',
        style: TextStyle(
            color: snow,
            fontSize: 18,
            fontFamily: 'SFDisplay',
            fontWeight: FontWeight.w600,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0, 0),
                blurRadius: 8.0,
                color: jetBlack80,
              ),
            ]),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 1.0),
        child: Text(' session',
            style: TextStyle(
                color: bone,
                fontFamily: 'SFDisplay',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 8.0,
                    color: jetBlack80,
                  ),
                ])),
      )
    ],
  );
}
