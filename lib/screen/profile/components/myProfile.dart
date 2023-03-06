import 'dart:ffi';
import 'dart:ui';

import 'package:balance/constants.dart';
import 'package:balance/feModels/categories.dart';
import 'package:balance/sharedWidgets/categories/categorySmall.dart';
import 'package:balance/sharedWidgets/classes/classItemCondensed1.dart';
import 'package:balance/sharedWidgets/reviewCard.dart';
import 'package:balance/sharedWidgets/unfollowDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../feModels/classModel.dart';
import '../../home/components/upcomingClassesItem.dart';

class PersonalProfile extends StatefulWidget {
  PersonalProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

List<Category> interests = categoriesList;
List<Category> myInterestsFinal = myInterests;
List<Class> savedClassesList = classList;

class _PersonalProfileState extends State<PersonalProfile> {
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

  var userInterests = ['Flexibility', 'Boxing', 'Tennis', 'Soccer'];

//----------
  @override
  void initState() {
    super.initState();
    getUserDetails();

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
  void getUserDetails() async {
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
      userFullName = '${sharedPrefs.getString('firstName')!}' +
          ' '
              '${sharedPrefs.getString('lastName')!}';
    }
    getSet2UserDetails();
    checkInterests();

    setState(() {});
  }

  void getSet2UserDetails() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var profilePictureNullCheck = sharedPrefs.getString('profileImageURL');
    if (profilePictureNullCheck != null) {
      profileImageUrl = sharedPrefs.getString('profileImageURL')!;
    }
  }

//----------
  void checkInterests() {
    for (var i = 0; i < interests.length; i++) {
      if (userInterests.contains(interests[i].categoryName)) {
        myInterestsFinal.add(interests[i]);
      }
    }
    ;
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
          Row(
            children: [
              Text(
                userFullName,
                style: TextStyle(
                    fontSize: 30,
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
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child:
              // ),
            ],
          ),
          Text(
            '@' + userName,
            style: TextStyle(
                fontSize: 18,
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

//Edit Profile button
  Widget editProfileButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 26.0),
      child: Container(
        alignment: Alignment.center,
        height: 35,
        width: (MediaQuery.of(context).size.width - (26 * 2) - 32 - 8),
        decoration: BoxDecoration(
            color: shark40, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Text(
            'Edit profile',
            style: TextStyle(
                color: jetBlack,
                fontFamily: 'SFDisplay',
                fontSize: 13.0,
                fontWeight: FontWeight.w600),
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
                  padding: const EdgeInsets.only(left: 26.0, right: 26.0),
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
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: SvgPicture.asset(
                          'assets/icons/generalIcons/settings.svg',
                          color: iconColor,
                          height: 15,
                          width: 15,
                        ),
                      ),
                    ),
                  )),
                ),
              ],
              title: Text(userFullName,
                  style: TextStyle(
                      color: _textColor,
                      fontFamily: 'SFDisplay',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0)),
            ),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: editProfileButton(),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 26.0, right: 26.0),
                child: Text(
                  'About me',
                  style: sectionTitles,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 26.0, right: 26.0),
                child: Text(
                  'Toronto, Ontario, Canada',
                  style: TextStyle(
                      color: jetBlack,
                      fontFamily: 'SFDisplay',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, left: 26.0, right: 26.0),
                child: Text(
                  "I've been looking for a boxing trainer these last few months and really want to get started with the right trainer! My hobbies include tennis, soccer, golf, and general working out.",
                  style: TextStyle(
                      color: jetBlack60,
                      fontFamily: 'SFDisplay',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ]),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Your Interests",
                  style: sectionTitles,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    height: 84,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 13, right: 13),
                      itemCount: myInterestsFinal.length,
                      itemBuilder: (context, index) {
                        final _likedInterests = myInterestsFinal[index];
                        return CategorySmall(
                          categoryImage: _likedInterests.categoryImage,
                          categoryName: _likedInterests.categoryName,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ]),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Saved Classes",
                  style: sectionTitles,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 250,
                  child: ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: 26, right: 26),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final _savedClasses = savedClassesList[index];
                      return ClassItemCondensed1(
                        classImageUrl: _savedClasses.classImageUrl,
                        buttonBookOrRebookText: 'Book',
                        classTitle: _savedClasses.className,
                        classTrainer: _savedClasses.classTrainerFirstName,
                        classTrainerImageUrl: _savedClasses.trainerImageUrl,
                      );
                    },
                  ),
                ),
              ),
            ]),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Class History",
                  style: sectionTitles,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 250,
                  child: ListView.builder(
                    primary: false,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(left: 26, right: 26),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final _savedClasses = savedClassesList[index];
                      return ClassItemCondensed1(
                        classImageUrl: _savedClasses.classImageUrl,
                        buttonBookOrRebookText: 'Rebook',
                        classTitle: _savedClasses.className,
                        classTrainer: _savedClasses.classTrainerFirstName,
                        classTrainerImageUrl: _savedClasses.trainerImageUrl,
                      );
                    },
                  ),
                ),
              ),
            ]),
            MultiSliver(children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 26.0, right: 26.0, bottom: 15.0),
                child: Text(
                  "Posted Reviews",
                  style: sectionTitles,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                child: ReviewCard(),
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     height: 250,
              //     child: ListView.builder(
              //       physics: NeverScrollableScrollPhysics(),
              //       scrollDirection: Axis.vertical,
              //       padding: EdgeInsets.only(left: 26, right: 26),
              //       itemCount: 3,
              //       itemBuilder: (context, index) {
              //         final _savedClasses = savedClassesList[index];
              //         return ClassItemCondensed1(
              //           classImageUrl: _savedClasses.classImage,
              //           buttonBookOrRebookText: 'Rebook',
              //           classTitle: _savedClasses.className,
              //           classTrainer: _savedClasses.classTrainerFirstName,
              //           classTrainerImageUrl: _savedClasses.trainerImageUrl,
              //         );
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 35,
              )
            ]),
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
