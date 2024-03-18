import 'package:balance/constants.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/sharedWidgets/categories/categoryListLrg.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'createClassStep4WhatYouWillNeed.dart';

class CreateClassCategory extends StatefulWidget {
  const CreateClassCategory({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassCategory> createState() => _CreateClassCategory();
}

class _CreateClassCategory extends State<CreateClassCategory> {
  //variables
  List<String> selectedCategories = [];
  int i = allCategories.length;
//----------
  @override
  void initState() {
    super.initState();
    checkSelectedCategories();
  }

  void checkSelectedCategories() {
    for (var category in allCategories) {
      category.categoryLiked =
          classTemplate.classCategories.contains(category.categoryName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      FitsyIconsSet1.arrowleft,
                      color: jetBlack60,
                      size: 15,
                    ),
                    const Text(
                      "Back",
                      style: logInPageNavigationButtons,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => CreateClassWhatYouWillNeed(
                            classTemplate: classTemplate,
                          )));
                },
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(slivers: [
        MultiSliver(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(children: [
                pageTitle(),
              ]),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: 5,
              left: 15,
              right: 15,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = allCategories[index];
                  return GestureDetector(
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Container(
                            decoration: BoxDecoration(
                                color: snow,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(category.categoryImage))),
                            child: Center(
                              child: Text(
                                category.categoryName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: snow,
                                    fontFamily: 'SFDisplay',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: Duration(milliseconds: 1200),
                          curve: Curves.fastLinearToSlowEaseIn,
                          decoration: BoxDecoration(
                            color: category.categoryLiked
                                ? jetBlack80
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Icon(
                            FitsyIconsSet1.checkmark,
                            size: category.categoryLiked ? 40 : 0,
                            color: snow,
                          )),
                        )
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        category.categoryLiked = !(category.categoryLiked);
                        HapticFeedback.selectionClick();
                      });
                      // categorySelectBloc.categoryLikedSink
                      //     .add(category.categoryLiked);
                    },
                  );
                },
                childCount: allCategories.length,
              ),
            ),
          )
        ])
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 55.0, top: 10.0),
        child: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: FooterButton(
                buttonColor: strawberry,
                textColor: snow,
                buttonText: 'Continue'),
          ),
          onTap: () => {
            selectedCategories.clear(),
            for (i = 0; i < allCategories.length; i++)
              {
                if (allCategories[i].categoryLiked == true)
                  {selectedCategories.add(allCategories[i].categoryName)}
                else
                  {selectedCategories.remove(allCategories[i].categoryName)}
              },
            classTemplate.classCategories = selectedCategories,
            if (classTemplate.classType == ClassType.Solo)
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClassPicture(
                          classTemplate: classTemplate,
                        )))
              }
            else if (classTemplate.classType == ClassType.Group)
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClassPicture(
                          classTemplate: classTemplate,
                        )))
              }
            else
              {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreateClassPicture(
                          classTemplate: classTemplate,
                        )))
              }
          },
        ),
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Padding(
    padding: const EdgeInsets.only(
      left: 15,
    ),
    child: Container(
        padding: EdgeInsets.only(top: 25, bottom: 25.0),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Select categories that this class falls under',
          style: logInPageTitleH3,
        )),
  );
}
