import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class Category {
  final String categoryName;
  final String categoryImage;

  Category({required this.categoryName, required this.categoryImage});
}

List<Category> categoriesList = [
  Category(
      categoryName: "Physique",
      categoryImage: "assets/categories/CategoryPhyisque.png"),
  Category(
      categoryName: "Conditioning",
      categoryImage: "assets/categories/CategoryPerformance.png"),
  Category(
      categoryName: "Flexibility",
      categoryImage: "assets/categories/CategoryFlexibility.png"),
  Category(
      categoryName: "Lifestyle",
      categoryImage: "assets/categories/CategoryLifestyle.png"),
  Category(
      categoryName: "Badminton",
      categoryImage: "assets/categories/CategoryBadminton.png"),
  Category(
      categoryName: "Baseball",
      categoryImage: "assets/categories/CategoryBaseball.png"),
  Category(
      categoryName: "Basketball",
      categoryImage: "assets/categories/CategoryBasketball.png"),
  Category(
      categoryName: "Boxing",
      categoryImage: "assets/categories/CategoryBoxing.png"),
  Category(
      categoryName: "Cricket",
      categoryImage: "assets/categories/CategoryCricket.png"),
  Category(
      categoryName: "Crossfit",
      categoryImage: "assets/categories/CategoryCrossfit.png"),
  Category(
      categoryName: "Cycling",
      categoryImage: "assets/categories/CategoryCycling.png"),
  Category(
      categoryName: "Football",
      categoryImage: "assets/categories/CategoryFootball.png"),
  Category(
      categoryName: "Golf",
      categoryImage: "assets/categories/CategoryGolf.png"),
  Category(
      categoryName: "Gymnastics",
      categoryImage: "assets/categories/CategoryGymnastics.png"),
  Category(
      categoryName: "Hockey",
      categoryImage: "assets/categories/CategoryHockey.png"),
  Category(
      categoryName: "Mixed Martial Arts",
      categoryImage: "assets/categories/CategoryMMA.png"),
  Category(
      categoryName: "Rugby",
      categoryImage: "assets/categories/CategoryRugby.png"),
  Category(
      categoryName: "Running",
      categoryImage: "assets/categories/CategoryRunning.png"),
  Category(
      categoryName: "Soccer",
      categoryImage: "assets/categories/CategorySoccer.png"),
  Category(
      categoryName: "Table Tennis",
      categoryImage: "assets/categories/CategoryTableTennis.png"),
  Category(
      categoryName: "Tennis",
      categoryImage: "assets/categories/CategoryTennis.png"),
  Category(
      categoryName: "Track & Field",
      categoryImage: "assets/categories/CategoryTNF.png"),
  Category(
      categoryName: "Volleyball",
      categoryImage: "assets/categories/CategoryVolleyball.png"),
  Category(
      categoryName: "Weight Lifting",
      categoryImage: "assets/categories/CategoryCWL.png"),
];

class CategoryListLarge extends StatelessWidget {
  const CategoryListLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 32.0, mainAxisSpacing: 20),
            itemCount: categoriesList.length,
            itemBuilder: (context, category) {
              return listItem(category);
            })
      ],
    );
  }

  Widget listItem(category) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(color: bone60, shape: BoxShape.circle),
        child: Center(
          child: ClipOval(
            child: Image.asset(
              categoriesList[category].categoryImage,
              height: 120,
              width: 120,
            ),
          ),
        ),
      ),
      onTap: () => {
        print(categoriesList[category].categoryName),
      },
    );
  }
}
