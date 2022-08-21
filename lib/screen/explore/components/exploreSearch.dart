import 'package:balance/constants.dart';
import 'package:balance/screen/explore/components/exploreHome.dart';
import 'package:balance/sharedWidgets/classes/classListHome.dart';
import 'package:balance/sharedWidgets/searchBarReadOnly.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class ExploreSearch extends StatelessWidget {
  const ExploreSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).size.height * 0.08;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26.0, bottom: 20),
              child: GestureDetector(
                child: Hero(
                  tag: 'ExploreTitle',
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: SvgPicture.asset('assets/icons/arrowLeft.svg'),
                      ),
                      // Text('Explore',
                      //     style: TextStyle(
                      //       fontSize: 16,
                      //       fontFamily: 'SFDisplay',
                      //       color: jetBlack,
                      //       fontWeight: FontWeight.w500,
                      //       decoration: TextDecoration.none,
                      //     ))
                      Padding(
                        padding: const EdgeInsets.only(left: 0, bottom: 0),
                        child: Text('Search', style: pageTitles),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(CupertinoPageRoute(
                    fullscreenDialog: true,
                    maintainState: true,
                    builder: (context) {
                      return Explore();
                    },
                  ));
                },
              ),
            ),
            // Hero(
            //   tag: 'ExploreTitle',
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 26.0, bottom: 15),
            //     child: Text('Search', style: pageTitles),
            //   ),
            // ),
            Hero(
              tag: 'SearchBar',
              child: SearchBar(
                isAutoFocusTrue: true,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 156.25,
                    decoration: BoxDecoration(
                      color: bone,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: SvgPicture.asset(
                            'assets/icons/searchIcons/SortIcon.svg',
                            color: jetBlack,
                            height: 16,
                            width: 16,
                          ),
                        ),
                        const Text('Sort',
                            style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            )),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 3.0, bottom: 10.0),
                          child: ClipOval(
                            child: Container(
                              width: 6, height: 6, color: Colors.transparent,
                              // strawberry,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 40,
                      width: 156.25,
                      decoration: BoxDecoration(
                        color: bone,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: SvgPicture.asset(
                              'assets/icons/searchIcons/FilterIcon.svg',
                              color: jetBlack,
                              height: 18,
                              width: 18,
                            ),
                          ),
                          const Text('Filter',
                              style: TextStyle(
                                color: jetBlack,
                                fontFamily: 'SFDisplay',
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 3.0, bottom: 10.0),
                            child: ClipOval(
                              child: Container(
                                  width: 6, height: 6, color: Colors.transparent
                                  // strawberry,
                                  ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
