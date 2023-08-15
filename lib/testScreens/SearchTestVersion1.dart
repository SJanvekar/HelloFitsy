import 'package:balance/constants.dart';
import 'package:balance/screen/home/home.dart';
import 'package:balance/sharedWidgets/classes/classListHome.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchTestV1 extends StatelessWidget {
  const SearchTestV1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).size.height * 0.10;
    var searchBarWidth = MediaQuery.of(context).size.width - (26 * 2) - 50;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26.0, bottom: 23.8),
              child: Padding(
                padding: const EdgeInsets.only(left: 0, bottom: 0),
                child: Text('Search', style: pageTitles),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: Hero(
                      tag: 'SearchBar',
                      child: FitsySearchBar(
                        isAutoFocusTrue: true,
                        searchHintText: 'Search trainers or classes',
                        callback: null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: GestureDetector(
                      child: SizedBox(
                        width: 50,
                        child: Text('Cancel',
                            style: TextStyle(
                              color: jetBlack80,
                              fontFamily: 'SFDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            )),
                      ),
                      onTap: () {
                        Navigator.pop(
                          context,
                          PageTransition(
                              child: Home(),
                              type: PageTransitionType.fade,
                              isIos: true,
                              reverseDuration: Duration(milliseconds: 300),
                              duration: Duration(milliseconds: 300)),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            ],
          ),
        ],
      ),
    ),
  );
}

//Search Bar Sliver Delegate
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._TabBar);

  final TabBar _TabBar;

  @override
  double get minExtent => 100;
  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        child: _TabBar,
        decoration: BoxDecoration(
          color: snow,
        ));
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
