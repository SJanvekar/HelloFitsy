import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/followingFeed.dart';
import 'package:balance/screen/home/components/homeClassItem.dart';
import 'package:balance/screen/home/components/upcomingClassesItem.dart';
import 'package:balance/screen/home/components/upcomingClassesFeed.dart';
import 'package:balance/screen/profileSidebar/sidebar.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../sharedWidgets/classes/classModel.dart';
import 'components/search.dart';

class HomeTest extends StatelessWidget {
  HomeTest({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<Class> allClasses = classList;

  @override
  Widget build(BuildContext context) {
    var searchBarWidth = MediaQuery.of(context).size.width - (26 * 2);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    return GestureDetector(
      child: Scaffold(
        key: _key,
        backgroundColor: snow,

        //Profile SideBar
        drawer: SideBar(),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,

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
            pinned: true,
            toolbarHeight: 50,
            centerTitle: true,
            elevation: 0,
            backgroundColor: snow,
            automaticallyImplyLeading: false,
            leadingWidth: 60,
            leading: Padding(
              padding: EdgeInsets.only(
                left: 26.0,
              ),

              //Profile Picture
              child: GestureDetector(
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/fitsy-5wx21.appspot.com/o/profilePictureSalman.jpeg?alt=media&token=7e20cf4e-a32a-4e1a-ae8d-6fd7a755cde1'),
                  backgroundColor: Colors.transparent,
                ),
                onTap: () => _key.currentState!.openDrawer(),
              ),
            ),

            //Typeface
            title: Image.asset(
              'assets/images/Typeface.png',
              height: 45,
            ),
            bottom: PreferredSize(
                child: Container(
                  color: shark40,
                  height: 1,
                ),
                preferredSize: Size.fromHeight(1)),

            //Notifications & Chat
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 26.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 30.0,
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
                    SvgPicture.asset(
                      'assets/icons/generalIcons/chat.svg',
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              )
            ],
          ),

          //Search Bar Sliver
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
                        isIos: true,
                        duration: Duration(milliseconds: 300)));
              },
            )),
            pinned: false,
          ),
          MultiSliver(children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 26.0, right: 26.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Classes',
                    style: TextStyle(
                      color: jetBlack,
                      fontFamily: 'SFDisplay',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      color: ocean,
                      fontFamily: 'SFDisplay',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
                  const EdgeInsets.only(left: 26.0, right: 26.0, top: 25.0),
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
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final classItem = classList[index];
                return HomeClassItem(
                  classTrainer: classItem.classTrainer,
                  userName: 'username',
                  className: classItem.className,
                  classType: classItem.classType,
                  classLocation: classItem.classLocation,
                  classPrice: classItem.classPrice,
                  classLiked: classItem.classLiked,
                  classImage: classItem.classImage,
                  trainerImageUrl: classItem.trainerImageUrl,
                  classDescription: classItem.classDescription,
                  classRating: classItem.classRating,
                  classReviews: classItem.classReview,
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
