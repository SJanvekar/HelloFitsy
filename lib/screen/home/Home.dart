import 'package:balance/Requests/ClassRequests.dart';
import 'package:balance/Requests/FollowingRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/HomeClassItem.dart';
import 'package:balance/screen/home/components/PARQ.dart';
import 'package:balance/screen/home/components/UpcomingClassesItem.dart';
import 'package:balance/sharedWidgets/noticeDisclaimer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../feModels/ClassModel.dart';
import '../../feModels/UserModel.dart';
import '../../sharedWidgets/bodyButton.dart';
import 'components/Search.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.userInstance}) : super(key: key);

  User userInstance;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Variables
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String profileImageUrl = "";
  List<Class> allClasses = [];

  //Update this to true once the app is launched
  bool isLoading = false;

  //----------
  @override
  void initState() {
    super.initState();
    getUserFollowing();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }

  //Function - Get Following List
  void getUserFollowing() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    FollowingRequests()
        .getFollowingList(sharedPrefs.getString('userName') ?? "")
        .then((val) async {
      if (val.data['success']) {
        print('successful get following list');
        // getClassFeed([
        //   for (dynamic document in (val.data['following'] as List<dynamic>))
        //     Following.fromJson(document).followingUsername
        // ]);
        isLoading = false;
      } else {
        //Remove print statement in production
        print('Empty Class List');
        isLoading = false;
      }
    });
  }

  void getClassFeed(List<String> followingUsernames) async {
    ClassRequests().getClass(followingUsernames).then((val) async {
      //get logged in user's following list
      if (val.data['success']) {
        print('successful get class feed');
        //TODO: Theoretically, you should be able to foreach and get list of classes
        //Hardcoded first item for now, since we're only getting one class
        allClasses
            .add(Class.fromJson((val.data['classArray'] as List<dynamic>)[0]));
      } else {
        print('error get class feed: ${val.data['msg']}');
      }
      setState(() {});
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

            // Typeface
            title: Image.asset(
              'assets/images/Typeface.png',
              height: 44,
            ),

            //Notifications & Chat & Create Class
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 25.0,
                        right: 35.0,
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
                ],
              )
            ],
          ),

          //Home Header - Upcoming Classes
          MultiSliver(children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, right: 26.0, top: 15.0),
              child: Text(
                'Hi, ${widget.userInstance.firstName}',
                style: const TextStyle(
                  color: jetBlack,
                  fontFamily: 'SFDisplay',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(
                  left: 26.0, right: 26.0, top: 2.0, bottom: 10.0),
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
            //Notice Disclaimer for PAR-Q
            MultiSliver(children: [
              GestureDetector(
                child: NoticeDisclaimer(
                    textBoxSize: 250,
                    disclaimerText:
                        'Complete a fitness questionnaire before purchasing your first class',
                    buttonText: 'Start',
                    buttonLeftRightPadding: 35.0),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: ParQuestionnaire(),
                          type: PageTransitionType.theme,
                          duration: Duration(milliseconds: 300),
                          reverseDuration: Duration(milliseconds: 300)));
                },
              )
            ]),

            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                  ),
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
            SizedBox(
              height: 25,
            ),
            if (isLoading)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 26.0,
                      right: 26.0,
                    ),
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
                  left: 26.0,
                  right: 26.0,
                  bottom: 20.0,
                ),
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
                    classItem: classItem,
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
