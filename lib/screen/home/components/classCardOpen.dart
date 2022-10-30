// ignore_for_file: file_names, prefer_const_constructors

import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/moreClassInfoModal.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:balance/sharedWidgets/userProfileComponentDark.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../sharedWidgets/classMoreActions.dart';

final oCcy = new NumberFormat("#,##0", "en_US");

class ClassCardOpen extends StatefulWidget {
  ClassCardOpen({
    Key? key,
    required this.classTrainer,
    required this.classTrainerFirstName,
    required this.classTrainerUserName,
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
  String classTrainerFirstName;
  String classTrainerUserName;
  String className;
  String classType;
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

  Widget classTrainer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UserProfileComponentDark(
            imageURL: widget.trainerImageUrl,
            profileImageRadius: 25,
            userFullName: widget.classTrainer,
            userFullNameFontSize: 15,
            userName: widget.classTrainerUserName,
            userNameFontSize: 13,
            userFirstName: widget.classTrainerFirstName,
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
            background: Hero(
              tag: widget.className,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.classImage,
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
            padding: const EdgeInsets.only(top: 5, left: 26.0, right: 26.0),
            child: classSubHeader(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: PageDivider(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "About this class",
                  style: profileSectionTitles,
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
            child: PageDivider(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "What to expect",
                  style: profileSectionTitles,
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
            child: PageDivider(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26.0, right: 26.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "What you'll need",
                  style: profileSectionTitles,
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
            child: PageDivider(),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 26.0, right: 26.0),
              child: classReviewsWidget())
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
            child: LoginFooterButton(
              buttonColor: strawberry,
              buttonText: 'Inquire',
              textColor: snow,
            ),
          )),
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
          trainerRating(),
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
  Widget trainerRating() {
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
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: jetBlack,
                  fontFamily: 'SFRounded'),
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
          child: CategorySmall(),
        ),
      ],
    );
  }

//Class Reviews
  Widget classReviewsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reviews',
                  style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('View all',
                      style: TextStyle(
                          fontFamily: 'SFDisplay',
                          color: shark,
                          fontSize: 15,
                          fontWeight: FontWeight.w600)),
                ),
                onTap: () => print('View all Reviews Button Pressed'),
              )
            ],
          ),
        ),
        ReviewCard(),
      ],
    );
  }
}

//Persistent Header Private Class
class _TitleSliverDelegate extends SliverPersistentHeaderDelegate {
  final String _classType;
  final String _classTitle;

  _TitleSliverDelegate(this._classType, this._classTitle);

  @override
  Widget build(
      BuildContext context, double shrjetBlackOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
          color: snow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 0,
                left: 20,
                bottom: 2,
              ),
              child: Text(
                _classType,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: jetBlack40,
                    letterSpacing: -0.75),
                maxLines: 1,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 52,
                    minHeight: 26,
                    maxWidth: 335,
                    minWidth: 335,
                  ),
                  child: AutoSizeText(
                    _classTitle,
                    minFontSize: 18,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: jetBlack,
                        letterSpacing: -0.75),
                    maxLines: 2,
                  ),
                )),
          ],
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 100;

  @override
  // TODO: implement minExtent
  double get minExtent => 74;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
