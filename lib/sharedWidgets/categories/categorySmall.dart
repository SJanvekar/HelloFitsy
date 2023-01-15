import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySmall extends StatelessWidget {
  CategorySmall({
    Key? key,
    required this.categoryImage,
    required this.categoryName,
  }) : super(key: key);

  String categoryImage;
  String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
      ),
      child: Column(children: [
        CircleAvatar(
          radius: 31,
          backgroundImage: AssetImage(categoryImage),
          backgroundColor: snow,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(
              categoryName,
              style: TextStyle(
                  color: jetBlack,
                  fontFamily: 'SFDisplay',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ))
      ]),
    );
  }
}
