// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../home.dart';

class Search extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).size.height * 0.028;
    var appHeaderSize = MediaQuery.of(context).size.height * 0.0775;
    var searchBarWidth = MediaQuery.of(context).size.width - (26 * 2) - 50;

    return GestureDetector(
      child: Scaffold(
        backgroundColor: snow,

        //Appbar (White top, this should be consitent on every page.)
        appBar: AppBar(
          toolbarHeight: 5,
          elevation: 0,
          backgroundColor: snow,
        ),
        body: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                //AppBar Sliver
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  toolbarHeight: appHeaderSize,
                  elevation: 0,
                  backgroundColor: snow,
                  automaticallyImplyLeading: false,
                  stretch: true,

                  //Title
                  flexibleSpace: Padding(
                    padding: EdgeInsets.only(
                      left: 26,
                      top: paddingTop,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Search', style: pageTitles),
                      ],
                    ),
                  ),
                ),

                //Search Sliver
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegateSearchBar(Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 26.0),
                          child: Hero(
                            tag: 'SearchBar',
                            child: SearchBar(
                              isAutoFocusTrue: true,
                              searchBarWidth: searchBarWidth,
                              searchHintText: 'Search trainers or classes',
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
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    duration: Duration(milliseconds: 300)),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )),
                  floating: true,
                ),

                //Tab Sliver
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: jetBlack80,
                      indicatorWeight: 2,
                      labelPadding: EdgeInsets.zero,
                      padding: EdgeInsets.only(right: 100, left: 26),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 0),
                      labelColor: jetBlack80,
                      labelStyle: TextStyle(
                          fontFamily: 'SFDisplay',
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      unselectedLabelColor: jetBlack40,
                      unselectedLabelStyle: TextStyle(
                          fontFamily: 'SFDisplay',
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(
                          text: 'Trainers',
                        ),
                        Tab(
                          text: 'Classes',
                        ),
                        Tab(
                          text: 'Categories',
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              color: snow,
              child: TabBarView(
                children: [
                  Center(
                      child: Text(
                    'Trainers',
                    style: pageTitles,
                  )),
                  Center(
                    child: Text(
                      'Classes',
                      style: pageTitles,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Categories',
                      style: pageTitles,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
    );
  }
}

//Tab Bar Sliver Delegate
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
    return Container(
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

//Search Bar Sliver Delegate
class _SliverAppBarDelegateSearchBar extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegateSearchBar(this._SearchBar);

  final Widget _SearchBar;

  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

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
  bool shouldRebuild(_SliverAppBarDelegateSearchBar oldDelegate) {
    return false;
  }
}
