import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategorySmall extends StatelessWidget {
  const CategorySmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/images/Tennis.png'),
            backgroundColor: snow,
          )
        ],
      ),
      Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            'Tennis',
            style: TextStyle(
                color: jetBlack,
                fontFamily: 'SFDisplay',
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ))
    ]);
  }
}
