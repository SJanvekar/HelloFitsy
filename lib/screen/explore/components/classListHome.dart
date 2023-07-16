import 'package:balance/screen/explore/components/exploreClassItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../feModels/classModel.dart';

class ClassListExplore extends StatefulWidget {
  const ClassListExplore({Key? key}) : super(key: key);

  @override
  State<ClassListExplore> createState() => _ClassListExploreState();
}

List<Class> allClasses = classList;

class _ClassListExploreState extends State<ClassListExplore> {
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
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
              return ExploreClassItem(
                classTrainer: classItem.classTrainer,
                userName: 'username',
                className: classItem.className,
                classType: classItem.classType,
                classLocationName: classItem.classLocationName,
                classPrice: classItem.classPrice,
                classLiked: classItem.classLiked,
                classImage: classItem.classImageUrl,
              );
            })
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
