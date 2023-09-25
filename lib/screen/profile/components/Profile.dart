import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:balance/Requests/FollowerRequests.dart';
import 'package:balance/Requests/FollowingRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/FollowerModel.dart';
import 'package:balance/feModels/FollowingModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/home/components/ProfileClassCard.dart';
import 'package:balance/sharedWidgets/unfollowDialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../feModels/Categories.dart';
import '../../../feModels/ClassModel.dart';
import '../../../sharedWidgets/categories/categorySmall.dart';

class UserProfile extends StatefulWidget {
  UserProfile({
    Key? key,
    required this.userID,
    required this.userFirstName,
    required this.userLastName,
    required this.userName,
    required this.profileImageURL,
  }) : super(key: key);

  //User details:
  String userID;
  String userFirstName;
  String userLastName;
  String userName;
  String profileImageURL;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Color titleColor = Colors.transparent;
  Color _textColor = Colors.transparent;
  Color iconCircleColor = shark60;
  Color iconColor = snow;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;
  bool isUserFollowing = false;
  late User user;

  //Interests Lists
  //A list contained within the Category model which holds the trainers' interests (since this list contains the category information)
  List<Category> trainerInterestsFinal = trainerInterests;
  //Original list of all category (interest) items ~ this contains the Category name and image
  List<Category> interests = categoriesList;
  //This is where the Trainer categories list will populate ~ this is only temporary until we retrieve the trainers' info //HARD CODED - MUST CHANGE
  var userInterests = [];

  //Class list
  List<Class> trainerClasses = classList;

  void handleFollowPress() async {
    setState(() {});
    EasyDebounce.debounce('followDebouncer', const Duration(milliseconds: 500),
        () => changeFollowStatus());
  }

  void changeFollowStatus() async {
    if (isUserFollowing) {
      addFollowing();
      addFollower();
    } else {
      removeFollowing();
      removeFollower();
    }
  }

  void isFollowing() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(sharedPrefs.getString('loggedUser') ?? ''));
    await FollowingRequests()
        .isFollowing(widget.userID, user.userID)
        .then((val) async {
      if (val.data['success']) {
        print('successful is following');
        isUserFollowing = val.data['found'];
      } else {
        print('error is following ${val.data['msg']}');
      }
      setState(() {
        isUserFollowing;
      });
    });
  }

  void addFollowing() async {
    FollowingRequests()
        .addFollowing(widget.userID, user.userID)
        .then((val) async {
      if (val.data['success']) {
        print('successful add following');
      } else {
        print('error add following ${val.data['msg']}');
      }
    });
  }

  void addFollower() async {
    FollowerRequests()
        .addFollower(user.userID, widget.userID)
        .then((val) async {
      if (val.data['success']) {
        print('successful add follower');
      } else {
        print('error add follower ${val.data['msg']}');
      }
    });
  }

  void removeFollowing() async {
    FollowingRequests()
        .removeFollowing(widget.userID, user.userID)
        .then((val) async {
      if (val.data['success']) {
        print('successful remove following');
      } else {
        print('error remove following ${val.data['msg']}');
      }
    });
  }

  void removeFollower() async {
    FollowerRequests()
        .removeFollower(user.userID, widget.userID)
        .then((val) async {
      if (val.data['success']) {
        print('successful remove follower');
      } else {
        print('error remove follower ${val.data['msg']}');
      }
    });
  }

//----------
  @override
  void initState() {
    super.initState();
    isFollowing();
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
    //Checks for categories that match the trainers' interests and populates trainerInterestsFinal //HARD CODED - MUST CHANGE
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
            (MediaQuery.of(context).size.height * 0.381 - kToolbarHeight);
  }

//Title Colour Function
  _followOnTap() {
    setState(() {
      isUserFollowing = !isUserFollowing;
      HapticFeedback.mediumImpact();
    });
    handleFollowPress();
  }

  //Class Type and Title
  Widget userTitleCard() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // userFullName
            widget.userFirstName + ' ' + widget.userLastName,
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
            '@' + widget.userName,
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
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                // Followers TextSpan denoting the number of followers a user has
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text:
                        // Following Count,
                        //HARD CODED - MUST CHANGE
                        '200',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: snow,
                        fontFamily: 'SFDisplay',
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 8.0,
                            color: jetBlack80,
                          ),
                        ]),
                  ),
                  TextSpan(
                    text:
                        // Following Count,
                        ' Followers',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: snow,
                        fontFamily: 'SFDisplay',
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            blurRadius: 8.0,
                            color: jetBlack80,
                          ),
                        ]),
                  ),
                ])),
              ],
            ),
          ),
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
              'Chat with ' + widget.userFirstName,
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

    contentBox(context) {
      return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Text(
                  'Are you sure you want to unfollow ' + widget.userName + '?',
                  style: TextStyle(
                      color: jetBlack80,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                            color: strawberry,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Unfollow',
                          style: TextStyle(
                              color: snow,
                              fontFamily: 'SFDisplay',
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      onTap: () =>
                          {_followOnTap(), Navigator.of(context).pop()}),
                  SizedBox(height: 5),
                  GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 105,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: jetBlack80,
                              fontFamily: 'SFDisplay',
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      onTap: () => {Navigator.of(context).pop()}),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

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
                              widget.profileImageURL,
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
                                        child: isUserFollowing
                                            ? followingButton()
                                            : followButton(),
                                        onTap: () => {
                                              if (isUserFollowing == true)
                                                {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          elevation: 0,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          child: contentBox(
                                                              context),
                                                        );
                                                      }),
                                                }
                                              else if (isUserFollowing == false)
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
              title: Text(widget.userFirstName + ' ' + widget.userLastName,
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
                    'About ' + widget.userFirstName,
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
                        child:
                            //HARD CODED - MUST CHANGE
                            Text(
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
                      //HARD CODED - MUST CHANGE
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

                // Trainer Bio //HARD CODED - MUST CHANGE
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

            //Trainer Interests (Specialities) //HARD CODED - MUST CHANGE
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  widget.userFirstName + "'s Specialities",
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

            //Trainer Classes //HARD CODED - MUST CHANGE
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Train with " + widget.userFirstName,
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
                        classItem: trainerClassInfo,
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
