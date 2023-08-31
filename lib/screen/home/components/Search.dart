// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:balance/constants.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/home/components/userListItem.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../home.dart';
import 'HomeClassItem.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  // ignore: prefer_const_constructors_in_immutables

  List<User> userSearchResult = [];
  void retrieveSearchResult(List<User> newResult) {
    setState(() {
      userSearchResult = newResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Class> allClasses = classList;
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
          length: 2,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                //AppBar Sliver
                SliverAppBar(
                  floating: true,
                  pinned: false,
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
                  delegate: _SliverAppBarDelegateSearchBar(Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 26.0),
                            child: Hero(
                              tag: 'SearchBar',
                              child: FitsySearchBar(
                                isAutoFocusTrue: true,
                                searchBarWidth: searchBarWidth,
                                searchHintText: 'Search trainers or classes',
                                callback: retrieveSearchResult,
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
                                          Duration(milliseconds: 0),
                                      duration: Duration(milliseconds: 0)),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
                  floating: false,
                ),

                //Tab Sliver
                SliverPersistentHeader(
                  pinned: false,
                  floating: true,
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: jetBlack80,
                      indicatorWeight: 2,
                      labelPadding: EdgeInsets.zero,
                      padding: EdgeInsets.only(
                        right: ((MediaQuery.of(context).size.width) * 0.5),
                        left: 15,
                      ),
                      indicatorPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                      ),
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
                  //Tab #1 - Users Search Tab

                  if (userSearchResult.isEmpty)

                    //Empty ClassList (No search results)
                    Center(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              color: shark,
                              size: 50,
                            ),
                            Text(
                              'No trainers found',
                              style: emptyListDisclaimerText,
                            ),
                          ],
                        ),
                      ),
                    ))
                  else
                    Center(
                      child: CustomScrollView(
                        slivers: [
                          MultiSliver(children: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                //Update this list to a list of users retrieved from search - we may need to work on this together.
                                final userItem = userSearchResult[index];

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 26.0, right: 26.0),
                                  child: UserProfileComponentLight(
                                    userFirstName: userItem.firstName,
                                    userLastName: userItem.lastName,
                                    userName: userItem.userName,
                                    imageURL: userItem.profileImageURL,
                                    profileImageRadius: 22.5,
                                    userFullNameFontSize: 15,
                                    userNameFontSize: 14,
                                  ),
                                );
                              },
                              childCount: userSearchResult.length,
                            )),
                          ]),
                        ],
                      ),
                    ),

                  //Tab #2 - Classes Search Tab

                  if (allClasses.isEmpty)

                    //Empty ClassList (No search results)
                    Center(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              color: shark,
                              size: 50,
                            ),
                            Text(
                              'No classes found',
                              style: emptyListDisclaimerText,
                            ),
                          ],
                        ),
                      ),
                    ))
                  else
                    Center(
                      child: CustomScrollView(
                        slivers: [
                          MultiSliver(children: [
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                //This will need to be replaced with a list of classes received from the search.
                                final classItem = allClasses[index];
                                return HomeClassItem(
                                  classItem: classItem,
                                );
                              },
                              childCount: allClasses.length,
                            )),
                          ]),
                        ],
                      ),
                    ),
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
