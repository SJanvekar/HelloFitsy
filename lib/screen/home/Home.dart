import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/FollowingFeed.dart';
import 'package:balance/screen/home/components/UpcomingClassesItem.dart';
import 'package:balance/screen/home/components/UpcomingClassesFeed.dart';
import 'package:balance/screen/profileSidebar/sidebar.dart';
import 'package:balance/sharedWidgets/classes/classListHome.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:page_transition/page_transition.dart';

import '../../testScreens/searchTestVersion1.dart';
import 'components/Search.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchBarWidth = MediaQuery.of(context).size.width - (26 * 2);
    return GestureDetector(
      child: Scaffold(
        backgroundColor: snow,

        //Profile SideBar
        drawer: SideBar(),
        drawerEdgeDragWidth: MediaQuery.of(context).size.width,

        //Appbar (White top, this should be consitent on every page.)
        appBar: AppBar(
          toolbarHeight: 5,
          elevation: 0,
          backgroundColor: snow,
        ),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              //AppBar Sliver
              SliverAppBar(
                floating: true,
                pinned: false,
                toolbarHeight: 55,
                centerTitle: true,
                elevation: 0,
                backgroundColor: snow,
                automaticallyImplyLeading: false,
                leadingWidth: 60,

                stretch: true,

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
                delegate: _SliverAppBarDelegate(Padding(
                  padding: const EdgeInsets.only(
                    top: 20.8,
                  ),
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Hero(
                            tag: 'SearchBar',
                            child: FitsySearchBar(
                              isAutoFocusTrue: false,
                              searchHintText: 'Search',
                              callback: null,
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
                  ),
                )),
                pinned: false,
              ),
            ];
          },
          body: Container(
            color: snow,
            height: 300,
            child: Column(
              children: [
                Expanded(child: UpcomingClassesFeed()),
              ],
            ),
          ),
        ),
      ),
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
    );
  }
}

//Search Bar Sliver Delegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._SearchBar);

  final Widget _SearchBar;

  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        child: _SearchBar,
        decoration: BoxDecoration(
          color: snow,
        ));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
