import 'dart:io';
import 'package:balance/sharedWidgets/categories/addRemoveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import 'categories.dart';

class CategoryListLarge extends StatefulWidget {
  const CategoryListLarge({Key? key}) : super(key: key);

  @override
  State<CategoryListLarge> createState() => _CategoryListLargeState();
}

List<Category> allCategories = categoriesList;

class _CategoryListLargeState extends State<CategoryListLarge> {
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: SizedBox(
              width: 323,
              height: 40,
              child: TextField(
                  controller: _inputController,
                  style: const TextStyle(
                      fontFamily: 'SFDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: jetBlack80),
                  cursorColor: ocean,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 11, bottom: 11),
                    fillColor: bone60,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                    hintText: 'Search Interests',
                    hintStyle: const TextStyle(
                      color: jetBlack20,
                      fontSize: 15,
                    ),
                    prefixIcon: Container(
                      width: 18,
                      height: 18,
                      padding: const EdgeInsets.only(
                          left: 18, top: 11, bottom: 11, right: 8),
                      child: SvgPicture.asset(
                          'assets/icons/generalIcons/search.svg'),
                    ),
                    suffixIcon: GestureDetector(
                        child: Container(
                            width: 18,
                            height: 18,
                            padding: const EdgeInsets.only(
                                left: 10, top: 11, bottom: 11, right: 10),
                            child: SvgPicture.asset(
                              'assets/icons/generalIcons/exit.svg',
                              height: 18,
                              width: 18,
                            )),
                        onTap: () => {
                              HapticFeedback.mediumImpact(),
                              _inputController.clear(),
                              searchCategories('')
                            }),
                  ),
                  onChanged: searchCategories),
            )),
        Expanded(
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
                  itemCount: allCategories.length,
                  itemBuilder: (context, index) {
                    final category = allCategories[index];
                    return GestureDetector(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: snow, shape: BoxShape.circle),
                            child: Center(
                              child: ClipOval(
                                child: Image.asset(
                                  category.categoryImage,
                                  height: 140,
                                  width: 140,
                                ),
                              ),
                            ),
                          ),
                          AddRemoveButton(
                            isAdd: category.categorySelected,
                          )
                        ],
                      ),
                      onTap: () => {
                        category.categorySelected = !category.categorySelected,
                      },
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }

  void searchCategories(String query) {
    final categoriesSearched = categoriesList.where((category) {
      final categoriesSearchedName = category.categoryName.toLowerCase();
      final input = query.toLowerCase();

      return categoriesSearchedName.contains(input);
    }).toList();

    setState(() => allCategories = categoriesSearched);
  }
}
