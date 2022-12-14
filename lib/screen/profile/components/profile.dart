import 'dart:ui';

import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/unfollowDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //User details:
  String profileImageUrl = "";
  String userName = "";
  String userFullName = "";
  String userFirstName = "";
  String userLastName = "";

  Color titleColor = Colors.transparent;
  Color _textColor = Colors.transparent;
  Color iconCircleColor = shark60;
  Color iconColor = snow;
  late ScrollController _scrollController;
  Brightness statusBarTheme = Brightness.dark;
  bool isFollowing = false;

//----------
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSet1UserDetails();
    getSet2UserDetails();
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
  void getSet1UserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var userNameNullCheck = sharedPrefs.getString('userName');
    var userFirstNameNullCheck = sharedPrefs.getString('firstName');
    var userLastNameNullCheck = sharedPrefs.getString('lastName');
    if (userNameNullCheck != null) {
      userName = sharedPrefs.getString('userName')!;
    }
    if (userFirstNameNullCheck != null && userLastNameNullCheck != null) {
      userFirstName = sharedPrefs.getString('firstName')!;
      userLastName = sharedPrefs.getString('lastName')!;
      userFullName = sharedPrefs.getString('firstName')! +
          sharedPrefs.getString('lastName')!;
    }
  }

  void getSet2UserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var profilePictureNullCheck = sharedPrefs.getString('profileImageURL');
    if (profilePictureNullCheck != null) {
      profileImageUrl = sharedPrefs.getString('profileImageURL')!;
    }
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
            userFullName,
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
            '@' + userName,
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

//Follow Button
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
              'Chat with ' + userFirstName,
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
                              profileImageUrl,
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
                                                                userFullName,
                                                            trainerImg:
                                                                profileImageUrl);
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
              title: Text(userFullName,
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
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                  padding:
                      const EdgeInsets.only(top: 15, left: 26.0, right: 26.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About ${userFirstName}',
                        style: profileSectionTitles,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
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
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Roger Federer holds several ATP records and is considered to be one of the greatest tennis players of all time. The Swiss player has proved his dominance on court with 20 Grand Slam titles and 103 career ATP titles. In 2003, he founded the Roger Federer Foundation, which is dedicated to providing education programs for children living in poverty in Africa and Switzerland',
                          style: TextStyle(
                              color: jetBlack60,
                              fontFamily: 'SFDisplay',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Text(
                          "${userFirstName}'s specialties",
                          style: profileSectionTitles,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: CategorySmall(),
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack80,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack60,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack40,
                  height: 200,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, left: 26.0, right: 26.0),
                child: Container(
                  color: jetBlack20,
                  height: 200,
                ),
              ),
            ])),
          ]),
    );
  }
}

// //Class Type and Title
// Widget userTitleCard() {
//   return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           ,
//           style: TextStyle(
//               fontSize: 26,
//               fontFamily: 'SFDisplay',
//               fontWeight: FontWeight.w600,
//               color: snow,
//               shadows: <Shadow>[
//                 Shadow(
//                   offset: Offset(0, 0),
//                   blurRadius: 8.0,
//                   color: jetBlack80,
//                 ),
//               ]),
//           maxLines: 1,
//         ),
//         Text(
//           '@salman',
//           style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//               color: snow,
//               fontFamily: 'SFDisplay',
//               shadows: <Shadow>[
//                 Shadow(
//                   offset: Offset(0, 0),
//                   blurRadius: 8.0,
//                   color: jetBlack80,
//                 ),
//               ]),
//           maxLines: 1,
//         ),
//         // trainerSubHeader(),
//       ]);

// }

// //Follow Button
// Widget followButton() {
//   return ClipRRect(
//     borderRadius: BorderRadius.circular(20),
//     child: BackdropFilter(
//       filter: new ImageFilter.blur(
//         sigmaX: 1,
//         sigmaY: 1,
//       ),
//       child: Container(
//         alignment: Alignment.center,
//         height: 34,
//         width: 90,
//         decoration: BoxDecoration(
//             color: shark40,
//             border: Border.all(color: shark60),
//             borderRadius: BorderRadius.circular(20)),
//         child: Text(
//           'Follow',
//           style: TextStyle(
//               color: snow,
//               fontFamily: 'SFDisplay',
//               fontSize: 13.0,
//               fontWeight: FontWeight.w600),
//         ),
//       ),
//     ),
//   );
// }

// //Follow Button
// Widget followingButton() {
//   return Container(
//     alignment: Alignment.center,
//     height: 34,
//     width: 90,
//     decoration: BoxDecoration(
//         color: strawberry, borderRadius: BorderRadius.circular(20)),
//     child: Text(
//       'Following',
//       style: TextStyle(
//           color: snow,
//           fontFamily: 'SFDisplay',
//           fontSize: 13.0,
//           fontWeight: FontWeight.w600),
//     ),
//   );
// }
