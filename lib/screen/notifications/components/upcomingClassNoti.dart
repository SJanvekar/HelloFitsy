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
      required this.notificationType,
      required this.notificationDate,
      required this.notificationMessage,
      required this.notificationImage})
      : super(key: key);

  String notificationType;
  DateTime notificationDate;
  String notificationMessage;
  String notificationImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, right: 26.0),
      child: Column(
        children: [
          //Upcoming Class notification
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
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
                                notificationType,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: jetBlack80,
                                    fontFamily: 'SFDisplay'),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
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
                            width: (MediaQuery.of(context).size.width) - 115,
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
                if (notificationType == 'Upcoming class')
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(notificationImage),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5)),
                  )
                else
                  ClipOval(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(notificationImage),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
