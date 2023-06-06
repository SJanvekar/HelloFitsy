// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/purchaseClassSelectDates.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/moreClassInfoModal.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:balance/sharedWidgets/userProfileComponentDark.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../feModels/classModel.dart';
import '../../../sharedWidgets/classMoreActions.dart';
import '../../profile/components/profile.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ClassCardOpen extends StatefulWidget {
  ClassCardOpen({
    Key? key,
    required this.classTrainer,
    required this.trainerFirstName,
    required this.trainerLastName,
    required this.className,
    required this.classType,
    required this.classLocation,
    required this.classPrice,
    required this.classLiked,
    required this.classImage,
    required this.trainerImageUrl,
    required this.classRating,
    required this.classReviews,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classWhatYouWillNeed,
  }) : super(key: key);

  String classTrainer;
  String trainerFirstName;
  String trainerLastName;
  String className;
  ClassType classType;
  String classLocation;
  double classPrice;
  bool classLiked;
  String classImage;
  String trainerImageUrl;
  double classRating;
  int classReviews;
  String classDescription;
  String classWhatToExpect;
  String classWhatYouWillNeed;

  @override
  State<ClassCardOpen> createState() => _ClassCardOpenState();
}

class _ClassCardOpenState extends State<ClassCardOpen> {
  Color iconCircleColor = shark60;
  Color iconColor = snow;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;

  //Get Trainer Details

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
  }

  //----------
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * 0.38 - kToolbarHeight);
  }

  //----------Widgets----------

  Widget classTrainer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserProfileComponentDark(
            imageURL: widget.trainerImageUrl,
            profileImageRadius: 25,
            userFullName:
                '${widget.trainerFirstName} ${widget.trainerLastName}',
            userFullNameFontSize: 16,
            userName: widget.classTrainer,
            userNameFontSize: 13,
            userFirstName: widget.trainerFirstName,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 26),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset('assets/icons/generalIcons/ellipses.svg',
                      color: bone),
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
    );
  }

  //Price Container
  Widget classPriceWidget() {
    return Container(
        color: snow,
        child: Row(
          children: [
            Text(
              '\$${oCcy.format(widget.classPrice.round())}',
              style: TextStyle(
                color: strawberry,
                fontSize: 26,
                fontFamily: 'SFDisplay',
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(' /session',
                  style: TextStyle(
                      color: shark,
                      fontFamily: 'SFDisplay',
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ));
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
                          widget.className,
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
            widget.classLocation,
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
        SvgPicture.asset(
          'assets/icons/generalIcons/star.svg',
          height: 14,
          width: 14,
          color: sunflower,
        ),

        //Rating (Numeric)
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Center(
            child: Text(
              '${widget.classRating}',
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
          widget.classDescription,
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
          widget.classWhatToExpect,
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
          widget.classWhatYouWillNeed,
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

  //Class Trainer Spotlight
  Widget classTrainerSpotlight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileComponentLight(
          imageURL: widget.trainerImageUrl,
          profileImageRadius: 25,
          userFullName: widget.trainerFirstName + ' ' + widget.trainerLastName,
          userFullNameFontSize: 16,
          userName: widget.classTrainer,
          userNameFontSize: 13,
          userFirstName: widget.trainerFirstName,
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.5, bottom: 8.5),
                    child: SvgPicture.asset(
                      'assets/icons/generalIcons/arrowLeft.svg',
                      color: iconColor,
                      height: 13,
                      width: 6,
                    ),
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
                Hero(
                  tag: widget.className,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.classImage,
                          ),
                          fit: BoxFit.cover),
                    ),
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
                  const EdgeInsets.only(right: 20.0, top: 11.5, bottom: 11.5),
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
                      child: SvgPicture.asset(
                        widget.classLiked
                            ? 'assets/icons/generalIcons/favouriteFill.svg'
                            : 'assets/icons/generalIcons/favouriteEmpty.svg',
                        color: widget.classLiked ? strawberry : iconColor,
                        height: 16,
                      ),
                    ),
                  ),
                )),
                onTap: () => {
                  setState(() {
                    widget.classLiked = !widget.classLiked;
                    HapticFeedback.mediumImpact();
                  })
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 14, bottom: 14),
                    child: SvgPicture.asset(
                      'assets/icons/generalIcons/ellipses.svg',
                      color: iconColor,
                      height: 13,
                      width: 6,
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 26.0, right: 26.0),
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
                              inputText: widget.classDescription);
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
                              inputText: widget.classWhatToExpect);
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
                              inputText: widget.classWhatYouWillNeed);
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
                            classImageUrl: widget.classImage,
                            className: widget.className,
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
