import 'package:balance/Requests/classRequests.dart';
import 'package:balance/Requests/userRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/homeClassItem.dart';
import 'package:balance/screen/home/components/upcomingClassesItem.dart';
import 'package:balance/screen/profile/components/myProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../feModels/classModel.dart';
import '../../sharedWidgets/bodyButton.dart';
import '../../sharedWidgets/searchBarWidget.dart';
import '../createClass/createClassStep1SelectType.dart';
import 'components/search.dart';
import 'dart:convert';

class HomeTest extends StatefulWidget {
  HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  //Variables
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String profileImageUrl = "";
  List<Class> allClasses = [];
  String username = "";
  String userFirstName = "";
  bool isLoading = true;

  //----------
  @override
  void initState() {
    super.initState();
    getUserInfo();
    getUserFollowing();
    // getClassFeed();
    setState(() {});
  }

  void getUserInfo() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    userFirstName = sharedPrefs.getString('firstName') ?? "";
    profileImageUrl = sharedPrefs.getString('profileImageURL') ?? "";

    print(userFirstName);
    print(profileImageUrl);
  }

  void getUserFollowing() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    UserRequests()
        .getUserFollowing(sharedPrefs.getString('userName') ?? "")
        .then((val) async {
      if (val.data['success']) {
        print('successful get following list');
        getClassFeed(val.data['following']);

        isLoading = false;
      }
    });
  }

  void getClassFeed(List<dynamic> followingList) async {
    ClassRequests().getClass(followingList).then((val) async {
      //get logged in user's following list

      if (val.data['success']) {
        print('successful get class feed');
        //Response represents a list of classes
        List<dynamic> receivedJSON = val.data['classArray'];
        //TODO: Theoretically, you should be able to foreach and get list of classes
        //Hardcoded first item for now, since we're only getting one class
        allClasses.add(Class.fromJson(receivedJSON[0]));
      } else {
        print('error get class feed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var searchBarWidth = MediaQuery.of(context).size.width - (26 * 2);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return GestureDetector(
      child: Scaffold(
        key: _key,
        backgroundColor: snow,

        // // Profile SideBar
        // drawer: SideBar(),
        // drawerEdgeDragWidth: MediaQuery.of(context).size.width,

        //Appbar (White section, this should be consitent on every page.)
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: snow,
        ),
        body: CustomScrollView(slivers: [
          //AppBar Sliver
          SliverAppBar(
            stretch: false,
            pinned: false,
            floating: true,
            toolbarHeight: 50,
            centerTitle: true,
            elevation: 0,
            backgroundColor: snow,
            automaticallyImplyLeading: false,
            // Profile
            leading: GestureDetector(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: CircleAvatar(
                    backgroundColor: bone,
                    backgroundImage: NetworkImage(profileImageUrl ?? ''),
                  ),
                ),
              ),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PersonalProfile(),
                ))
              },
            ),

            // Typeface
            title: Image.asset(
              'assets/images/Typeface.png',
              height: 44,
            ),

            //Notifications & Chat & Create Class
            actions: [
              Row(
                children: [
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/icons/generalIcons/create.svg',
                      height: 20,
                      width: 20,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: CreateClassSelectType(
                                isTypeSelected: false,
                                classTemplate: classTemplate,
                              ),
                              type: PageTransitionType.fade,
                              isIos: false,
                              duration: Duration(milliseconds: 0),
                              reverseDuration: Duration(milliseconds: 0)));
                    },
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 25.0,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/generalIcons/notifications.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    onTap: () {
                      print("Notifications Button Pressed");
                      // Navigator.of(context).push(CupertinoPageRoute(
                      //     fullscreenDialog: true,
                      //     builder: (context) => CreateClassType()));
                    },
                  ),

                  //DEPRECATED SEARCH ICON

                  // Padding(
                  //   padding: const EdgeInsets.only(right: 26.0),
                  //   child: GestureDetector(
                  //     child: SvgPicture.asset(
                  //       'assets/icons/generalIcons/search.svg',
                  //       height: 20,
                  //       width: 20,
                  //     ),
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           PageTransition(
                  //               child: Search(),
                  //               type: PageTransitionType.fade,
                  //               isIos: false,
                  //               duration: Duration(milliseconds: 0),
                  //               reverseDuration: Duration(milliseconds: 0)));
                  //     },
                  //   ),
                  // ),
                  //
                  //
                ],
              )
            ],
          ),

          // Search Bar Sliver
          SliverPersistentHeader(
            floating: true,
            delegate: _SliverSearchBarDelegate(GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                      tag: 'SearchBar',
                      child: FitsySearchBar(
                        isAutoFocusTrue: false,
                        searchBarWidth: searchBarWidth,
                        searchHintText: 'Search',
                      )),
                  Container(
                      height: 45,
                      width: searchBarWidth,
                      color: Colors.transparent)
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Search(),
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 0),
                        reverseDuration: Duration(milliseconds: 0)));
              },
            )),
            pinned: false,
          ),

          MultiSliver(children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, right: 26.0, top: 15.0),
              child: Text(
                'Hi, ${userFirstName}',
                style: TextStyle(
                  color: jetBlack,
                  fontFamily: 'SFDisplay',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0, top: 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Check out your upcoming classes',
                    style: TextStyle(
                      color: jetBlack,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: ocean,
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 26.0, right: 26.0),
                  child: UpcomingClassesItem(),
                );
              },
              childCount: 1,
            )),
            Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, right: 26.0, top: 35.0),
              child: Text(
                'For you',
                style: TextStyle(
                  color: jetBlack,
                  fontFamily: 'SFDisplay',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Padding(
                    padding:
                        const EdgeInsets.only(left: 26.0, right: 26.0, top: 20),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(color: Colors.white),
                      child: SkeletonItem(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                    shape: BoxShape.circle,
                                    width: 50,
                                    height: 50),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: SkeletonParagraph(
                                  style: SkeletonParagraphStyle(
                                      lines: 2,
                                      spacing: 4,
                                      lineStyle: SkeletonLineStyle(
                                        randomLength: true,
                                        height: 10,
                                        borderRadius: BorderRadius.circular(8),
                                        minLength:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        maxLength:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12),
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                                width: double.infinity,
                                height: 400,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(height: 10),
                        ],
                      )),
                    ),
                  ),
                  childCount: 3,
                ),
              )
            else if (allClasses.isEmpty && !isLoading)
              Padding(
                padding: const EdgeInsets.only(
                    left: 26.0, right: 26.0, top: 20.0, bottom: 20.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SvgPicture.asset(
                        'assets/icons/generalIcons/listIcon.svg',
                        color: shark,
                        height: 50,
                      ),
                    ),
                    Text(
                      'No classes',
                      textAlign: TextAlign.center,
                      style: emptyListDisclaimerText,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: GestureDetector(
                        child: BodyButton(
                            buttonColor: strawberry,
                            textColor: snow,
                            buttonText: 'Search for classes'),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Search(),
                                  type: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                  reverseDuration: Duration(milliseconds: 0)));
                        },
                      ),
                    )
                  ],
                ),
              )

            //If the user has liked classes ~ display the list
            else
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final classItem = allClasses[index];
                  return HomeClassItem(
                    classTrainer: classItem.classTrainer,
                    className: classItem.className,
                    classType: classItem.classType,
                    classLocation: classItem.classLocation,
                    classPrice: classItem.classPrice,
                    classLiked: classItem.classLiked,
                    classImage: classItem.classImageUrl,
                    trainerImageUrl: classItem.trainerImageUrl,
                    classDescription: classItem.classDescription,
                    classRating: classItem.classRating,
                    classReviews: classItem.classReview,
                    trainerFirstName: classItem.trainerFirstName,
                    trainerLastName: classItem.trainerLastName,
                    classWhatToExpect: classItem.classWhatToExpect,
                    classWhatYouWillNeed: classItem.classUserRequirements,
                  );
                },
                childCount: allClasses.length,
              )),
          ])
        ]),
      ),
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
    );
  }
}

//Search Bar Sliver Delegate
class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverSearchBarDelegate(this._SearchBar);

  final Widget _SearchBar;

  @override
  double get minExtent => 86.5;
  @override
  double get maxExtent => 86.5;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        child: Center(child: _SearchBar),
        decoration: BoxDecoration(
          color: snow,
        ));
  }

  @override
  bool shouldRebuild(_SliverSearchBarDelegate oldDelegate) {
    print('rebuilding');
    return true;
  }
}
