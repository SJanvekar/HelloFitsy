import 'dart:io';
import 'package:balance/sharedWidgets/categories/addRemoveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'classModel.dart';

class ClassListLarge extends StatefulWidget {
  const ClassListLarge({Key? key}) : super(key: key);

  @override
  State<ClassListLarge> createState() => _ClassListLargeState();
}

List<Class> allClasses = classList;

class _ClassListLargeState extends State<ClassListLarge> {
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 32.0,
                  mainAxisSpacing: 20),
              itemCount: classList.length,
              itemBuilder: (context, index) {
                final classItem = classList[index];
                return GestureDetector(
                  child: Stack(
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(color: snow, shape: BoxShape.circle),
                        child: Center(
                          child: ClipOval(
                            child: Image.asset(
                              classItem.classImage,
                              height: 140,
                              width: 140,
                            ),
                          ),
                        ),
                      ),
                      AddRemoveButton(
                        isAdd: classItem.classLiked,
                      )
                    ],
                  ),
                  onTap: () => {
                    classItem.classLiked = !classItem.classLiked,
                  },
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
