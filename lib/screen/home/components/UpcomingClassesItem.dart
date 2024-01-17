// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class UpcomingClassesItem extends StatelessWidget {
  UpcomingClassesItem({Key? key}) : super(key: key);

  //HARD CODED - MUST CHANGE
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - (20 * 2);
    return Column(
      children: [
        //Upcoming Class Card
        Container(
          height: 100,
          width: width,
          decoration: BoxDecoration(
            color: bone60,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Class Details
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Class Time //HARD CODED - MUST CHANGE
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              Jiffy.parse(now.toString())
                                  .format(pattern: "MMM do, yyy "),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: jetBlack80,
                                  fontFamily: 'SFRounded'),
                            ),
                          ),

                          //Class Title //HARD CODED - MUST CHANGE
                          SizedBox(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 3.0),
                              child: Text(
                                'Monday Evening Personal Training Session',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: jetBlack,
                                    fontFamily: 'SFDisplay'),
                                maxLines: 2,
                              ),
                            ),
                          ),

                          //Class Trainer //HARD CODED - MUST CHANGE
                          Row(
                            children: [
                              Text(
                                'with Amanda',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: jetBlack40,
                                    fontFamily: 'SFDisplay'),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 4.0),
                              //   child: CircleAvatar(
                              //     radius: 8,
                              //     foregroundImage: NetworkImage(
                              //         'https://www.strongfitnessmag.com/wp-content/uploads/2021/04/Sydney-Cummings-on-set.jpg'),
                              //     backgroundColor: Colors.transparent,
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Jiffy.parse(now.toString()).format(pattern: "h:mm a"),
                          style: classStartTime,
                        ),
                        Text(
                          Jiffy.parse(now.toString()).format(pattern: "h:mm a"),
                          style: classEndTime,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
