import 'dart:io';
import 'package:balance/screen/home/components/homeClassItem.dart';
import 'package:balance/sharedWidgets/categories/addRemoveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'classModel.dart';

class ClassListHome extends StatefulWidget {
  const ClassListHome({Key? key}) : super(key: key);

  @override
  State<ClassListHome> createState() => _ClassListHomeState();
}

List<Class> allClasses = classList;

class _ClassListHomeState extends State<ClassListHome> {
  var _inputController = TextEditingController();
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
                  classTrainer: classItem.classTrainer,
                  userName: 'username',
                  className: classItem.className,
                  classType: classItem.classType,
                  classLocation: classItem.classLocation,
                  classPrice: classItem.classPrice,
                  classLiked: classItem.classLiked,
                  classImage: classItem.classImage,
                  trainerImageUrl: classItem.trainerImageUrl,
                  classDescription: classItem.classDescription,
                  classRating: classItem.classRating,
                  classReviews: classItem.classReview,
                  trainerFirstName: classItem.classTrainerFirstName,
                  classWhatToExpect: classItem.classWhatToExpect,
                  classWhatYouWillNeed: classItem.classUserRequirements,
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
