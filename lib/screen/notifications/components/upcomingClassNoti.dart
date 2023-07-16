// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class UpcomingClassNotification extends StatelessWidget {
  UpcomingClassNotification(
      {Key? key,
      required this.notificationDate,
      required this.notificationMessage})
      : super(key: key);

  DateTime notificationDate;
  String notificationMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Upcoming Class notification
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Notification Title
                            Text(
                              'Upcoming Class',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: jetBlack80,
                                  fontFamily: 'SFDisplay'),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: ClipOval(
                                  child: Container(
                                height: 2,
                                width: 2,
                                color: jetBlack60,
                              )),
                            ),

                            //Notification Time
                            Text(
                              Jiffy.parse(notificationDate.toString())
                                  .format(pattern: "h:mm a"),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: jetBlack60,
                                  fontFamily: 'SFRounded'),
                            ),
                          ],
                        ),

                        //Class Title
                        SizedBox(
                          width: (MediaQuery.of(context).size.width) - 110,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              notificationMessage,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: jetBlack60,
                                  fontFamily: 'SFDisplay'),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
