import 'package:balance/constants.dart';
import 'package:balance/screen/createClass/createClassPicture.dart';
import 'package:balance/screen/createClass/createClassStep1SelectType.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/sharedWidgets/categories/categoryListLrg.dart';
import 'package:balance/feModels/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/searchBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../login/components/categorySelect_bloc.dart';
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
  final categorySelectBloc = CategorySelectBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,

      //AppBar
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: TextButton(
                onPressed: () {
                  print("Back");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => CreateClassWhatYouWillNeed(
                          classTemplate: classTemplate)));
                },
                child: Text("Back", style: logInPageNavigationButtons),
              ),
            ),
          ],
        ),
      ),

      body: CustomScrollView(slivers: [
        MultiSliver(children: [
          pageTitle(),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final category = allCategories[index];
                return Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                  child: GestureDetector(
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
                        category.categoryLiked
                            ? Container(
                                decoration: BoxDecoration(
                                  color: jetBlack80,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                  'assets/icons/generalIcons/circleClassSelected.svg',
                                  height: 50,
                                  width: 50,
                                )),
                              )
                            : Container(),
                      ],
                    ),
                    onTap: () {
                      category.categoryLiked = !(category.categoryLiked);
                      HapticFeedback.selectionClick();
                      setState(() {});
                    },
                  ),
                );
              },
              childCount: allCategories.length,
            ),
          )
        ])
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 55.0, top: 10.0),
        child: GestureDetector(
          child: LoginFooterButton(
              buttonColor: strawberry, textColor: snow, buttonText: 'Continue'),
          onTap: () => {
            selectedCategories.clear(),
            for (i = 0; i < allCategories.length; i++)
              {
                if (allCategories[i].categoryLiked == true)
                  {selectedCategories.add(allCategories[i].categoryName)}
                else
                  {selectedCategories.remove(allCategories[i].categoryName)}
              },
            widget.classTemplate.classCategories = selectedCategories,
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateClassPicture(
                      classTemplate: classTemplate,
                    )))
          },
        ),
      ),
    );
  }

  // void sendUserModel() {
  //   userTemplate.likedClasses = <String>[];
  //   userTemplate.classHistory = <String>[];
  //   userTemplate.followers = <String>[];
  //   userTemplate.following = <String>[];

  //   //Auth Service Call
  //   AuthService().signUp(userTemplate).then((val) {
  //     // print("Whatever");
  //     if (val.data['success']) {
  //       print('Successful user add');
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => MainPage()));
  //     } else {
  //       print("MEGASS ERROR KEK: ${val.data}");
  //     }
  //   });
  // }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 46.5,
        right: 46.5,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 25, bottom: 25.0),
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Select categories that this class falls under',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
