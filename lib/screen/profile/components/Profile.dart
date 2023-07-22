import 'dart:ui';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/ProfileClassCard.dart';
import 'package:balance/sharedWidgets/unfollowDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../feModels/Categories.dart';
import '../../../feModels/ClassModel.dart';
import '../../../sharedWidgets/categories/categorySmall.dart';

class UserProfile extends StatefulWidget {
  UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //User details:
  // String profileImageUrl = "";
  // String userName = "";
  // String userFullName = "";
  // String userFirstName = "";
  // String userLastName = "";

  Color titleColor = Colors.transparent;
  Color _textColor = Colors.transparent;
  Color iconCircleColor = shark60;
  Color iconColor = snow;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;
  bool isFollowing = false;

  //Interests Lists
  //A list contained within the Category model which holds the trainers' interests (since this list contains the category information)
  List<Category> trainerInterestsFinal = trainerInterests;
  //Original list of all category (interest) items ~ this contains the Category name and image
  List<Category> interests = categoriesList;
  //This is where the Trainer categories list will populate ~ this is only temporary until we retrieve the trainers' info
  var userInterests = [];

  //Class list
  List<Class> trainerClasses = classList;

//----------
  @override
  void initState() {
    super.initState();

    print(trainerClasses.length);
    //Checks the trainer interests and creates a list from the categories models
    checkInterests();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? jetBlack : Colors.transparent;
          iconCircleColor = _isSliverAppBarExpanded ? snow : shark60;
          iconColor = _isSliverAppBarExpanded ? jetBlack : snow;
          statusBarTheme =
              _isSliverAppBarExpanded ? Brightness.light : Brightness.dark;
        });
      });
  }

  //----------
  void checkInterests() {
    //Checks for categories that match the trainers' interests and populates trainerInterestsFinal
    userInterests = ['Tennis', 'Boxing'];
    interests.forEach((interestsItem) {
      if (userInterests.contains(interestsItem.categoryName)) {
        trainerInterestsFinal.add(interestsItem);
      }
    });
  }

//----------
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset >
            (MediaQuery.of(context).size.height * 0.37 - kToolbarHeight);
  }

//Title Colour Function
  _followOnTap() {
    setState(() {
      isFollowing = !isFollowing;
      HapticFeedback.mediumImpact();
    });
  }

  //Class Type and Title
  Widget userTitleCard() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // userFullName
            'Salman Janvekar',
            style: TextStyle(
                fontSize: 26,
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
            maxLines: 1,
          ),
          Text(
            '@salmanjanvekar',
            // userName,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: snow,
                fontFamily: 'SFDisplay',
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0, 0),
                    blurRadius: 8.0,
                    color: jetBlack80,
                  ),
                ]),
            maxLines: 1,
          ),
          // trainerSubHeader(),
        ]);
  }

  //Follow button ~ State 0
  Widget followButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: new ImageFilter.blur(
          sigmaX: 1,
          sigmaY: 1,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 34,
          width: 90,
          decoration: BoxDecoration(
              color: shark40,
              border: Border.all(color: shark60),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            'Follow',
            style: TextStyle(
                color: snow,
                fontFamily: 'SFDisplay',
                fontSize: 13.0,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

//Follow Button ~ state 1 (Following)
  Widget followingButton() {
    return Container(
      alignment: Alignment.center,
      height: 34,
      width: 90,
      decoration: BoxDecoration(
          color: strawberry, borderRadius: BorderRadius.circular(20)),
      child: Text(
        'Following',
        style: TextStyle(
            color: snow,
            fontFamily: 'SFDisplay',
            fontSize: 13.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }

//Contact button
  Widget contactTrainerButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: new ImageFilter.blur(
          sigmaX: 1,
          sigmaY: 1,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 34,
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: shark60),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'Chat with Salman',
              // userFirstName,
              style: TextStyle(
                  color: snow,
                  fontFamily: 'SFDisplay',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var top = 0.0;
    var max = 0.0;
    var mobilePadding = MediaQuery.of(context).padding;
    var mobilePaddingPlusToolBar = mobilePadding.top + 55;

    //Hides the top status bar for iOS & Android
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    //Shows the top status bar for iOS & Android
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

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
      body: CustomScrollView(
          shrinkWrap: false,
          controller: _scrollController,
          slivers: [
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
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/fitsy-5wx21.appspot.com/o/private%2Fvar%2Fmobile%2FContainers%2FData%2FApplication%2FC30AF58C-8871-4EF9-92C2-D3FA41E5A4B7%2Ftmp%2Fimage_picker_4C4728D4-1416-4F73-BA34-0E3C86ABBFDD-2819-0000024C398674C2.jpg?alt=media&token=1299217a-1d3e-48cf-9180-f28a1e8c58f6',
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
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      max = 382.76 - mobilePaddingPlusToolBar;
                      top =
                          constraints.biggest.height - mobilePaddingPlusToolBar;

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
                            children: [
                              userTitleCard(),
                              Padding(
                                padding: const EdgeInsets.only(top: 7.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        child: isFollowing
                                            ? followingButton()
                                            : followButton(),
                                        onTap: () => {
                                              if (isFollowing == true)
                                                {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CustomDialogBox(
                                                            trainerName:
                                                                'Salman',
                                                            // userFullName,
                                                            trainerImg: '');
                                                      })
                                                }
                                              else if (isFollowing == false)
                                                {_followOnTap()}
                                            }),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: contactTrainerButton(),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                expandedTitleScale: 1,
                centerTitle: false,
              ),
              title: Text('Salman Janvekar',
                  // userFullName,
                  style: TextStyle(
                      color: _textColor,
                      fontFamily: 'SFDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 26.0, top: 11.5, bottom: 11.5),
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

            // About Trainer
            MultiSliver(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 26.0, right: 26.0),
                  child: Text(
                    'About Salman',
                    // ${userFirstName}',
                    style: sectionTitles,
                  ),
                ),

                //Trainer Rating Average + Location
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 26.0, right: 26.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/generalIcons/star.svg',
                        color: sunflower,
                        height: 17.5,
                        width: 17.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text(
                          '4.5',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFRounded',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        child: ClipOval(
                          child: Container(
                            height: 2,
                            width: 2,
                            color: jetBlack,
                          ),
                        ),
                      ),
                      Text(
                        'Toronto, Ontario, Canada',
                        style: TextStyle(
                            color: jetBlack,
                            fontFamily: 'SFDisplay',
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),

                // Trainer Bio
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, left: 26.0, right: 20.0),
                  child: Text(
                    'Roger Federer holds several ATP records and is considered to be one of the greatest tennis players of all time. The Swiss player has proved his dominance on court with 20 Grand Slam titles and 103 career ATP titles. In 2003, he founded the Roger Federer Foundation, which is dedicated to providing education programs for children living in poverty in Africa and Switzerland',
                    style: TextStyle(
                        color: jetBlack60,
                        fontFamily: 'SFDisplay',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),

            //Trainer Interests (Specialities)
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Salman's Specialities",
                  style: sectionTitles,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    height: 84,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 13, right: 13),
                      itemCount: trainerInterestsFinal.length,
                      itemBuilder: (context, index) {
                        final likedInterests = trainerInterestsFinal[index];
                        return CategorySmall(
                          categoryImage: likedInterests.categoryImage,
                          categoryName: likedInterests.categoryName,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]),

            //Trainer Classes
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Train with Salman",
                  style: sectionTitles,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 340,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 26.0, right: 26.0),
                    itemCount: trainerClasses.length,
                    itemBuilder: (context, index) {
                      final trainerClassInfo = trainerClasses[index];
                      return ProfileClassCard(
                        classTrainer: trainerClassInfo.classTrainer,
                        className: trainerClassInfo.className,
                        classType: trainerClassInfo.classType,
                        classLocationName: trainerClassInfo.classLocationName,
                        classPrice: trainerClassInfo.classPrice,
                        classLiked: trainerClassInfo.classLiked,
                        classImage: trainerClassInfo.classImageUrl,
                        trainerImageUrl: trainerClassInfo.trainerImageUrl,
                        classDescription: trainerClassInfo.classDescription,
                        classRating: trainerClassInfo.classOverallRating,
                        classReviews: trainerClassInfo.classReviewsAmount,
                        trainerFirstName: trainerClassInfo.trainerFirstName,
                        trainerLastName: trainerClassInfo.trainerLastName,
                        classWhatToExpect: trainerClassInfo.classWhatToExpect,
                        classWhatYouWillNeed:
                            trainerClassInfo.classUserRequirements,
                        classTimes: [],
                      );
                    },
                  ),
                ),
              ),
            ]),

            MultiSliver(children: [
              SizedBox(height: 60),
            ])
          ]),
    );
  }
}
