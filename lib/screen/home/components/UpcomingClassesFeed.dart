import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/upcomingClassMoreInfo.dart';
import 'package:balance/screen/home/components/upcomingClassesItem.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingClassesFeed extends StatelessWidget {
  UpcomingClassesFeed({Key? key}) : super(key: key);

  List<Class> allClasses = classList;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.only(left: 26.0, right: 26.0),
    //   child: Column(children: [
    //     UpcomingClassesItem(),
    //   ]),
    // );
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final classItem = classList[index];
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: UpcomingClassesItem(),
            ),
            onTap: () => {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) =>
                      UpcomingClassMoreInfo(classItem: classItem))),
            },
          );
        },
        childCount: 1,
      ),
    );
  }
}
