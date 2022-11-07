import 'package:balance/constants.dart';
import 'package:balance/screen/home/components/upcomingClassesItem.dart';
import 'package:balance/feModels/classModel.dart';
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
    return Flexible(
        child: ListView(children: [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder: ((context, index) {
            final classItem = classList[index];
            return UpcomingClassesItem();
          }))
    ]));
  }
}
