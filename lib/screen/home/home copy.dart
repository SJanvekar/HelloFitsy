import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/homeClassItem.dart';
import 'package:balance/screen/home/components/upcomingClassesItem.dart';
import 'package:balance/screen/profile/components/myProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../feModels/classModel.dart';
import '../../sharedWidgets/bodyButton.dart';
import '../../sharedWidgets/searchBarWidget.dart';
import '../createClass/createClassStep1SelectType.dart';
import 'components/search.dart';

class HomeTest extends StatefulWidget {
  HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  //Variables
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String profileImageUrl = "";
  List<Class> allClasses = classList;

  //----------
  @override
  void initState() {
    super.initState();
    getUserProfilePictures();
  }

  void getUserProfilePictures() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    var profilePictureNullCheck = sharedPrefs.getString('profileImageURL');
    if (profilePictureNullCheck != null) {
      profileImageUrl = sharedPrefs.getString('profileImageURL')!;
    }
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
                    backgroundImage: NetworkImage(profileImageUrl),
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
                      'assets/icons/generalIcons/createClass.svg',
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
                  Padding(
                    padding: const EdgeInsets.only(right: 26.0),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        'assets/icons/generalIcons/search.svg',
                        height: 20,
                        width: 20,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Search(),
                                type: PageTransitionType.fade,
                                isIos: false,
                                duration: Duration(milliseconds: 0),
                                reverseDuration: Duration(milliseconds: 0)));
                      },
                    ),
                  ),
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
                      child: SearchBar(
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
                        isIos: false,
                        duration: Duration(milliseconds: 250),
                        reverseDuration: Duration(milliseconds: 250)));
              },
            )),
            pinned: false,
          ),

          MultiSliver(children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, right: 26.0, top: 15.0),
              child: Text(
                'Hi, Salman',
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
            if (savedClassesList.isEmpty)
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
                      'Such Empty',
                      textAlign: TextAlign.center,
                      style: emptyListDisclaimerText,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: BodyButton(
                          buttonColor: strawberry,
                          textColor: snow,
                          buttonText: 'Search for classes'),
                    )
                  ],
                ),
              )

            //If the user has liked classes ~ display the list
            else
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final classItem = classList[index];
                  return HomeClassItem(
                    classTrainer: classItem.classTrainer,
                    userName: classItem.classTrainerUsername,
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
                    trainerFirstName: classItem.classTrainerFirstName,
                    classWhatToExpect: classItem.classWhatToExpect,
                    classWhatYouWillNeed: classItem.classUserRequirements,
                  );
                },
                childCount: classList.length,
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
