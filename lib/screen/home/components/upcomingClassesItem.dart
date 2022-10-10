// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class UpcomingClassesItem extends StatelessWidget {
  UpcomingClassesItem({Key? key}) : super(key: key);

  DateTime now = DateTime.now();
  String dayNow = DateFormat.d().format(DateTime.now());
  String monthNow = DateFormat.MMM().format(DateTime.now());
  String timeNow = DateFormat.jm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Upcoming Class Card
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: bone60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Day + Month
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayNow,
                            style: TextStyle(
                                color: jetBlack60,
                                fontFamily: 'SFRounded',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            monthNow,
                            style: TextStyle(
                                color: jetBlack60,
                                fontFamily: 'SFRounded',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                    //Divider
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          color: shark60,
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
                          //Class Time
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              timeNow,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: jetBlack60,
                                  fontFamily: 'SFRounded'),
                            ),
                          ),

                          //Class Title
                          SizedBox(
                            width: 210,
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

                          //Class Trainer
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
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: CircleAvatar(
                                  radius: 8,
                                  foregroundImage: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/fitsy-5wx21.appspot.com/o/8BCF146D-E6AD-4E23-AD5F-6FFF97A63B6C.jpeg?alt=media&token=c4811f11-46b3-4bfd-a610-bead8933eac7'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: SvgPicture.asset(
                    'assets/icons/generalIcons/arrowRight.svg',
                    color: shark,
                    height: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
