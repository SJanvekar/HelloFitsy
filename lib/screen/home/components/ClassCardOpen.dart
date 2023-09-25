// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/Requests/ClassLikedRequests.dart';
import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/home/components/purchaseClassSelectDates.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/moreClassInfoModal.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCardPublic.dart';
import 'package:balance/sharedWidgets/userProfileComponentDark.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../feModels/ClassModel.dart';
import '../../../sharedWidgets/classMoreActions.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ClassCardOpen extends StatefulWidget {
  ClassCardOpen({Key? key, required this.classItem}) : super(key: key);

  Class classItem;

  @override
  State<ClassCardOpen> createState() => _ClassCardOpenState();
}

class _ClassCardOpenState extends State<ClassCardOpen> {
  Color iconCircleColor = shark60;
  Color iconColor = snow;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;
  bool classLiked = false;
  //Get Trainer Details
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
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          iconCircleColor = _isSliverAppBarExpanded ? snow : shark60;
          iconColor = _isSliverAppBarExpanded ? jetBlack : snow;
          statusBarTheme =
              _isSliverAppBarExpanded ? Brightness.light : Brightness.dark;
        });
      });
    getIsLiked();
  }

  //----------Functions-----------//
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * 0.38 - kToolbarHeight);
  }

  //----------Widgets----------//

  Widget classTrainer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserProfileComponentDark(
            userID: trainerUserID,
            userFirstName: trainerFirstName,
            userLastName: trainerLastName,
            userName: trainerUsername,
            profileImageURL: trainerImageURL,
            profileImageRadius: 25,
            userFullNameFontSize: 16,
            userNameFontSize: 13,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 26),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.more_horiz_rounded,
                    color: iconColor,
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
    );
  }

//Class Type and Title
  Widget classTitle() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: AutoSizeText(
                          widget.classItem.className,
                          minFontSize: 22,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'SFDisplay',
                            fontWeight: FontWeight.w600,
                            color: jetBlack,
                          ),
                        ),
                      )
                    ]),
              ),
            ],
          )
        ]);
  }

//Class Location
  Widget classSubHeader() {
    return Container(
      color: snow,
      child: Row(
        children: [
          classRating(),
          Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: ClipOval(
                child: Container(
                  color: jetBlack,
                  height: 3,
                  width: 3,
                ),
              )),
          Text(
            widget.classItem.classLocationName,
            style: TextStyle(
                color: jetBlack,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'SFDisplay'),
          ),
        ],
      ),
    );
  }

//Class Trainer Rating
  Widget classRating() {
    return Row(
      children: [
        //Star Icon
        Icon(
          Icons.stars_rounded,
          color: sunflower,
          size: 20,
        ),

        //Rating (Numeric)
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Center(
            child: Text(
              '${widget.classItem.classOverallRating}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: jetBlack,
                  fontFamily: 'SFDisplay'),
            ),
          ),
        ),
      ],
    );
  }

//Class Desc
  Widget classDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.classItem.classDescription,
          overflow: TextOverflow.ellipsis,
          maxLines: 9,
          style: TextStyle(
            fontFamily: 'SFDisplay',
            color: jetBlack80,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  //Class What To Expect
  Widget classWhatToExpect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.classItem.classWhatToExpect,
          overflow: TextOverflow.ellipsis,
          maxLines: 9,
          style: TextStyle(
              fontFamily: 'SFDisplay',
              color: jetBlack80,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  //Class What You'll Need
  Widget classWhatYouwillNeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.classItem.classUserRequirements,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
          style: TextStyle(
              fontFamily: 'SFDisplay',
              color: jetBlack80,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

//Class Categories
  Widget classCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Text('Related Categories',
              style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CategorySmall(
            categoryImage: '',
            categoryName: '',
          ),
        ),
      ],
    );
  }

//Class Reviews
  Widget classReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewCard(),
      ],
    );
  }

  //Highly Rated Badge
  Widget highlyRatedClassBadge() {
    return Container(
      height: 25,
      padding: EdgeInsets.only(left: 8, right: 8),
      decoration: const BoxDecoration(
          color: sunflower,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
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

  //Class Trainer Spotlight
  Widget classTrainerSpotlight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileComponentLight(
          userID: trainerUserID,
          userFirstName: trainerFirstName,
          userLastName: trainerLastName,
          userName: trainerUsername,
          profileImageURL: trainerImageURL,
          profileImageRadius: 25,
          userFullNameFontSize: 16,
          userNameFontSize: 13,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            //Implement the Trainer bio here
            'Roger Federer holds several ATP records and is considered to be one of the greatest tennis players of all time. The Swiss player has proved his dominance on court with 20 Grand Slam titles and 103 career ATP titles. In 2003, he founded the Roger Federer Foundation, which is dedicated to providing education programs for children living in poverty in Africa and Switzerland',
            style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack80,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  //----------Body----------
  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    var max = 0.0;
    var mobilePadding = MediaQuery.of(context).padding;
    var mobilePaddingPlusToolBar = mobilePadding.top + 55;

    return Scaffold(
      backgroundColor: snow,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarBrightness: statusBarTheme),
      ),
      body: CustomScrollView(controller: _scrollController, slivers: [
        //App Bar
        SliverAppBar(
          leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 26.0,
                top: 11.5,
                bottom: 11.5,
              ),
              child: ClipOval(
                  child: BackdropFilter(
                filter: new ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(color: iconCircleColor),
                  child: Icon(
                    Icons.chevron_left_rounded,
                    color: iconColor,
                    size: 26,
                  ),
                ),
              )),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          leadingWidth: 58,
          automaticallyImplyLeading: false,
          backgroundColor: snow,
          elevation: 0,
          toolbarHeight: 55,
          stretch: true,
          floating: false,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * 0.38,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [StretchMode.zoomBackground],
            background: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.classItem.classImageUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        snow.withOpacity(0.0),
                        jetBlack.withOpacity(0.15),
                        jetBlack.withOpacity(0.35),
                      ],
                          stops: [
                        0.0,
                        0.6,
                        1.0
                      ])),
                ),
              ],
            ),
            titlePadding: EdgeInsets.zero,
            title: Padding(
              padding: const EdgeInsets.only(
                left: 26.0,
              ),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  max = 382.76 - mobilePaddingPlusToolBar;
                  top = constraints.biggest.height - mobilePaddingPlusToolBar;

                  if (top > max) {
                    max = top;
                  }
                  if (top == mobilePaddingPlusToolBar) {
                    top = 0.0;
                  }

                  top = top / max;

                  return Opacity(
                    opacity: top,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [classTrainer()],
                      ),
                    ),
                  );
                },
              ),
            ),
            expandedTitleScale: 1,
            centerTitle: false,
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 15.0, top: 11.5, bottom: 11.5),
              child: GestureDetector(
                child: ClipOval(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 1,
                    sigmaY: 1,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(color: iconCircleColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 2),
                      child: Icon(
                        classLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: classLiked ? strawberry : iconColor,
                        size: 20,
                      ),
                    ),
                  ),
                )),
                onTap: () {
                  setState(() {
                    classLiked = !classLiked;
                    HapticFeedback.mediumImpact();
                  });
                  handleLikedPress();
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 26.0, top: 11.5, bottom: 11.5),
              child: ClipOval(
                  child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1,
                  sigmaY: 1,
                ),
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(color: iconCircleColor),
                  child: Icon(
                    Icons.more_horiz_rounded,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              )),
            ),
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: EdgeInsets.only(
              top: 15.0,
              left: 26.0,
            ),

            //Highly Rated Badge
            //Row is added to reduce the size of the highly rated badge
            child: Row(
              //HARD CODED - MUST CHANGE replace with classOverallRating
              children: [
                if (5.0 > 4.7) highlyRatedClassBadge(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
            child: classTitle(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 26.0, right: 26.0),
            child: classSubHeader(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: PageDivider(leftPadding: 26.0, rightPadding: 26.0),
          ),

          //Class Description
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About this class",
                  style: sectionTitles,
                ),
                GestureDetector(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: ocean,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return moreClassInfo(
                              inputText: widget.classItem.classDescription);
                        })
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 26.0, right: 26.0),
            child: classDesc(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: PageDivider(leftPadding: 26.0, rightPadding: 26.0),
          ),

          //Class What To Expect
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "What to expect",
                  style: sectionTitles,
                ),
                GestureDetector(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: ocean,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return moreClassInfo(
                              inputText: widget.classItem.classWhatToExpect);
                        })
                  },
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 15, left: 26.0, right: 26.0),
            child: classWhatToExpect(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: PageDivider(leftPadding: 26.0, rightPadding: 26.0),
          ),

          //Class What you'll need
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "What you'll need",
                  style: sectionTitles,
                ),
                GestureDetector(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: ocean,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return moreClassInfo(
                              inputText:
                                  widget.classItem.classUserRequirements);
                        })
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 26.0, right: 26.0),
            child: classWhatYouwillNeed(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: PageDivider(
              leftPadding: 26.0,
              rightPadding: 26.0,
            ),
          ),

          //Class Trianer Spotlight
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Text(
              "Trainer Spotlight",
              style: sectionTitles,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, left: 26.0, right: 26.0),
              child: classTrainerSpotlight()),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: PageDivider(leftPadding: 26.0, rightPadding: 26.0),
          ),

          //Class Reviews
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Reviews",
                  style: sectionTitles,
                ),
                GestureDetector(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: ocean,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // onTap:
                  //Implement expanded review view for classes here
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 26.0, right: 26.0),
            child:
                classReviews(), // The reviews list needs to be implemented (Horizontal)
          ),
          SizedBox(
            height: 35,
          )
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
            child: Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: GestureDetector(
                child: FooterButton(
                  buttonColor: strawberry,
                  buttonText: 'Purchase Class',
                  textColor: snow,
                ),
                onTap: () {
                  HapticFeedback.lightImpact();
                  Timer(Duration(milliseconds: 150), () {
                    showCupertinoModalPopup(
                        semanticsDismissible: true,
                        barrierDismissible: true,
                        barrierColor: jetBlack60,
                        context: context,
                        builder: (BuildContext builder) {
                          return PurchaseClassSelectDates(
                            classImageUrl: widget.classItem.classImageUrl,
                            className: widget.classItem.className,
                          );
                        });
                  });
                },
              ),
            ),
          )),
    );
  }
}
