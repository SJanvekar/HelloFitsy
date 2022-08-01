// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpcomingClasses extends StatelessWidget {
  const UpcomingClasses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Upcoming Class Time
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
          child: Center(
              child: Text('3:30 PM',
                  style: TextStyle(
                    color: jetBlack40,
                    fontFamily: 'SFDisplay',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ))),
        ),

        //Upcoming Class Card
        Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 26.0),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: bone60,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14.5, bottom: 14.5),
              child: Row(
                children: [
                  //Trainer Image
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('assets/images/profilePictureDefault.png'),
                      backgroundColor: snow,
                    ),
                  ),

                  //Divider
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        color: jetBlack20,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  //Class Details
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Class Type
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'Group Session',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: jetBlack60,
                                fontFamily: 'SFDisplay'),
                          ),
                        ),

                        //Class Title
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            'Yute training program - Golf',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: jetBlack,
                                fontFamily: 'SFDisplay'),
                          ),
                        ),

                        //Class Trainer
                        Text(
                          'with Will Xian',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: jetBlack40,
                              fontFamily: 'SFDisplay'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
