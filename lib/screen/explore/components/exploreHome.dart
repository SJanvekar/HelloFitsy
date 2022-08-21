// ignore_for_file: prefer_const_constructors

import 'package:balance/constants.dart';
import 'package:balance/screen/explore/components/classListHome.dart';
import 'package:balance/screen/explore/components/exploreSearch.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 5,
          elevation: 0,
          backgroundColor: snow,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  Hero(
                    tag: 'ExploreTitle',
                    child: Row(
                      children: [
                        Text('Explore', style: pageTitles),
                      ],
                    ),
                  ),
                ),
                pinned: false,
              ),
              SliverPersistentHeader(
                delegate: _SliverSearchBarDelegate(
                  GestureDetector(
                    child: Stack(
                      children: [
                        Hero(
                            tag: 'SearchBar',
                            child: SearchBar(
                              isAutoFocusTrue: false,
                            )),
                        Container(
                            height: 50, width: 323, color: Colors.transparent)
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return ExploreSearch();
                        },
                      ));
                    },
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Expanded(child: ClassListExplore()),
        ));
  }
}

// class MySliverAppBar extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;

//   MySliverAppBar({required this.expandedHeight});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 26.0, bottom: 20),
//           child: Hero(
//             tag: 'ExploreTitle',
//             child: Row(
//               children: [
//                 Text('Explore', style: pageTitles),
//               ],
//             ),
//           ),
//         ),
//         GestureDetector(
//           child: Stack(
//             children: [
//               Hero(
//                   tag: 'SearchBar',
//                   child: SearchBar(
//                     isAutoFocusTrue: false,
//                   )),
//               Container(height: 50, width: 323, color: Colors.transparent)
//             ],
//           ),
//           onTap: () {
//             Navigator.of(context).push(CupertinoPageRoute(
//               fullscreenDialog: true,
//               builder: (context) {
//                 return ExploreSearch();
//               },
//             ));
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   double get maxExtent => expandedHeight;

//   @override
//   double get minExtent => 100;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }

// Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 26.0, bottom: 20),
//               child: Hero(
//                 tag: 'ExploreTitle',
//                 child: Row(
//                   children: [
//                     Text('Explore', style: pageTitles),
//                   ],
//                 ),
//               ),
//             ),
//             GestureDetector(
//               child: Stack(
//                 children: [
//                   Hero(
//                       tag: 'SearchBar',
//                       child: SearchBar(
//                         isAutoFocusTrue: false,
//                       )),
//                   Container(height: 50, width: 323, color: Colors.transparent)
//                 ],
//               ),
//               onTap: () {
//                 Navigator.of(context).push(CupertinoPageRoute(
//                   fullscreenDialog: true,
//                   builder: (context) {
//                     return ExploreSearch();
//                   },
//                 ));
//               },
//             ),
//             Expanded(
//               child: ClassListHorizontal(),
//             ),
//             Expanded(
//               child: ClassListLarge(),
//             ),
//           ],
//         ),

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._title);

  final Widget _title;

  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 26.0, bottom: 5.0),
          child: _title,
        ),
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

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverSearchBarDelegate(this._searchBar);

  final Widget _searchBar;

  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
        child: _searchBar,
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
