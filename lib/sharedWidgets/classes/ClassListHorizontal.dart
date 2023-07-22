import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../feModels/Categories.dart';

class ClassListHorizontal extends StatefulWidget {
  const ClassListHorizontal({Key? key}) : super(key: key);

  @override
  State<ClassListHorizontal> createState() => _ClassListHorizontalState();
}

List<Category> allCategories = categoriesList;

class _ClassListHorizontalState extends State<ClassListHorizontal> {
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 0.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemExtent: 80,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipOval(
                            child: Container(
                              height: 20,
                              width: 20,
                              color: jetBlack,
                            ),
                          ),
                        ),
                    itemCount: categoriesList.length),
              ),
            ),
          ],
        ),
      ),
    );

    // ListView(
    //   children: [
    //     ListView.builder(
    //         padding: EdgeInsets.zero,
    //         shrinkWrap: true,
    //         physics: const NeverScrollableScrollPhysics(),
    //         scrollDirection: Axis.horizontal,
    //         itemCount: classList.length,
    //         itemBuilder: (context, index) {
    //           final classItem = classList[index];
    //           return HomeClassItem(
    //             classTrainer: classItem.classTrainer,
    //             userName: 'username',
    //             className: classItem.className,
    //             classType: classItem.classType,
    //             classLocation: classItem.classLocation,
    //             classPrice: classItem.classPrice,
    //             classLiked: classItem.classLiked,
    //             classImage: classItem.classImage,
    //           );
    //         })
    //   ],
    // );
  }

  void refresh() {
    setState(() {});
  }
}
