// ignore_for_file: unnecessary_new, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/classCardOpen.dart';
import 'package:balance/screen/home/components/homeClassItem.dart';
import 'package:balance/screen/home/components/upcomingClasses.dart';
import 'package:balance/sharedWidgets/classes/classListHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balance/screen/createClass/createClassType.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        elevation: 0,
        backgroundColor: snow,
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                pinned: false,
                toolbarHeight: 55,
                centerTitle: false,
                elevation: 0,
                backgroundColor: snow,
                automaticallyImplyLeading: false,
                stretch: true,
                titleSpacing: 0,
                title: Padding(
                    padding: const EdgeInsets.only(left: 26.0, bottom: 10),
                    child: Image.asset(
                      'assets/images/Typeface.png',
                      height: 45,
                    )),
                bottom: PreferredSize(
                    child: Container(
                      color: shark40,
                      height: 1,
                    ),
                    preferredSize: Size.fromHeight(1)),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 26.0, bottom: 8),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: SvgPicture.asset(
                              'assets/icons/CreateClass.svg',
                              height: 20,
                              width: 20,
                            ),
                          ),
                          onTap: () {
                            print("Create Class Button Pressed");
                            Navigator.of(context).push(CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => CreateClassType()));
                          },
                        ),
                        SvgPicture.asset(
                          'assets/icons/Chat.svg',
                          height: 20,
                          width: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SliverPersistentHeader(
                floating: true,
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: jetBlack80,
                    indicatorWeight: 2,
                    labelPadding: EdgeInsets.zero,
                    padding: EdgeInsets.only(right: 180, left: 20),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 5),
                    labelColor: jetBlack80,
                    labelStyle: TextStyle(
                        fontFamily: 'SFDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    unselectedLabelColor: jetBlack40,
                    unselectedLabelStyle: TextStyle(
                        fontFamily: 'SFDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    tabs: [
                      Tab(
                        text: 'Home',
                      ),
                      Tab(
                        text: 'Upcoming',
                      ),
                    ],
                  ),
                ),
                pinned: false,
              ),
            ];
          },
          body: Container(
            color: snow,
            child: TabBarView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: ClassListHome(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 26.0, right: 26.0, bottom: 30, top: 30),
                      child: Text(
                        '$now',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: jetBlack,
                            fontFamily: 'SFDisplay'),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Nothing scheduled for today',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: jetBlack40,
                              fontFamily: 'SFDisplay'),
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                      width: 110,
                      height: 30,
                      decoration: BoxDecoration(
                          color: strawberry,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Find classes',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: snow,
                              fontFamily: 'SFDisplay'),
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 26.0, right: 26.0, bottom: 20, top: 30),
                      child: Text(
                        'July 28th',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: jetBlack,
                            fontFamily: 'SFDisplay'),
                      ),
                    ),
                    UpcomingClasses(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//         overlays: SystemUiOverlay.values);
//     return Scaffold(
//         backgroundColor: snow,
//         appBar: AppBar(
//           toolbarHeight: 55,
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: snow,
//           automaticallyImplyLeading: false,
//           titleSpacing: 0,
//           title: Padding(
//               padding: const EdgeInsets.only(left: 26.0, bottom: 10),
//               child: Image.asset(
//                 'assets/images/Typeface.png',
//                 height: 45,
//               )),
//           bottom: PreferredSize(
//               child: Container(
//                 color: shark40,
//                 height: 1,
//               ),
//               preferredSize: Size.fromHeight(1)),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 26.0, bottom: 8),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20.0),
//                       child: SvgPicture.asset(
//                         'assets/icons/CreateClass.svg',
//                         height: 20,
//                         width: 20,
//                       ),
//                     ),
//                     onTap: () {
//                       print("Create Class Button Pressed");
//                       Navigator.of(context).push(CupertinoPageRoute(
//                           fullscreenDialog: true,
//                           builder: (context) => CreateClassType()));
//                     },
//                   ),
//                   SvgPicture.asset(
//                     'assets/icons/Chat.svg',
//                     height: 20,
//                     width: 20,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//         body: tabBar());
//   }
// }

//TabBar
Widget tabBar() {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 10,
        backgroundColor: snow,
        bottom: const TabBar(
          indicatorColor: jetBlack80,
          indicatorWeight: 2,
          labelPadding: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(horizontal: 20),
          indicatorPadding: EdgeInsets.only(left: 20, right: 20),
          labelColor: jetBlack,
          labelStyle: TextStyle(
              fontFamily: 'SFDisplay',
              fontSize: 15,
              fontWeight: FontWeight.w600),
          unselectedLabelColor: shark,
          unselectedLabelStyle: TextStyle(
              fontFamily: 'SFDisplay',
              fontSize: 15,
              fontWeight: FontWeight.w500),
          tabs: [
            Tab(
              text: 'Feed',
            ),
            Tab(
              text: 'Upcoming Classes',
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: ClassListHome(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 26.0, right: 26.0, bottom: 30, top: 30),
                child: Text(
                  'Today',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: jetBlack,
                      fontFamily: 'SFDisplay'),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Nothing scheduled for today',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: jetBlack40,
                        fontFamily: 'SFDisplay'),
                  ),
                ),
              ),
              Center(
                  child: Container(
                width: 110,
                height: 30,
                decoration: BoxDecoration(
                    color: strawberry, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'Find classes',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: snow,
                        fontFamily: 'SFDisplay'),
                  ),
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 26.0, right: 26.0, bottom: 20, top: 30),
                child: Text(
                  'July 28th',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: jetBlack,
                      fontFamily: 'SFDisplay'),
                ),
              ),
              UpcomingClasses(),
            ],
          ),
        ],
      ),
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        child: _tabBar,
        decoration: BoxDecoration(
            color: snow,
            border: Border(
              bottom: BorderSide(width: 1, color: shark20),
            )));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
