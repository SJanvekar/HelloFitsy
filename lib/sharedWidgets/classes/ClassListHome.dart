import 'package:balance/screen/home/components/HomeClassItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../feModels/ClassModel.dart';

class ClassListHome extends StatefulWidget {
  const ClassListHome({Key? key}) : super(key: key);

  @override
  State<ClassListHome> createState() => _ClassListHomeState();
}

List<Class> allClasses = classList;

class _ClassListHomeState extends State<ClassListHome> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: classList.length,
              itemBuilder: (context, index) {
                final classItem = classList[index];
                return HomeClassItem(
                  classItem: classItem,
                );
              })
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
