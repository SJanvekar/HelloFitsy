// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:balance/constants.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/notifications/components/upcomingClassNoti.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notifications extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  Notifications({Key? key}) : super(key: key);

  List<Map> list = [
    {
      "time": "2023-07-13T19:41:00.000Z",
      "type": "Upcoming class",
      "message":
          "Youth Tennis Fundraiser Program by The Sick Kids Cancer Society",
      "image":
          "https://warwick.ac.uk/services/sport/active/tennis/kids-tennis/banner.jpg",
    },
    {
      "time": "2023-07-13T09:41:18.000Z",
      "type": "New follower",
      "message": "Roger Federer started following you",
      "image":
          "https://static01.nyt.com/images/2022/09/15/sports/15federer-assess1/15federer-assess1-videoSixteenByNine3000.jpg",
    },
    {
      "time": "2023-07-12T10:29:35.000Z",
      "type": "Cancelled session",
      "message":
          "Roger Federer has cancelled their booking for Youth Tennis Fundraiser Program by The Sick Kids Cancer Society scheduled on Monday July 3rd 2023, 10:30 am",
      "image":
          "https://static01.nyt.com/images/2022/09/15/sports/15federer-assess1/15federer-assess1-videoSixteenByNine3000.jpg",
    },
    {
      "time": "2023-06-17T12:29:35.000Z",
      "type": "New class purchase",
      "message":
          "Roger Federer has purchased Youth Tennis Fundraiser Program by The Sick Kids Cancer Society scheduled on Saturday July 1st 2023, 10:30 am",
      "image":
          "https://static01.nyt.com/images/2022/09/15/sports/15federer-assess1/15federer-assess1-videoSixteenByNine3000.jpg",
    },
    {
      "time": "2023-06-16T10:31:12.000Z",
      "type": "New class available",
      "message":
          "Roger Federer has posted a new class Youth Tennis Fundraiser Program by The Sick Kids Cancer Society",
      "image":
          "https://static01.nyt.com/images/2022/09/15/sports/15federer-assess1/15federer-assess1-videoSixteenByNine3000.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: snow,

        //Appbar (White top, this should be consitent on every page.)
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: false,
          elevation: 0,
          backgroundColor: snow,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 0,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      //Icon: arrowLeft from the Fitsy icon ttf library
                      Icon(
                        FitsyIconsSet1.arrowleft,
                        color: jetBlack80,
                        size: 14,
                      ),
                      Text("Cancel", style: logInPageNavigationButtons),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            //AppBar Sliver
            SliverAppBar(
              floating: true,
              pinned: false,
              toolbarHeight: 50,
              elevation: 0,
              backgroundColor: snow,
              automaticallyImplyLeading: false,
              stretch: true,

              //Title
              flexibleSpace: Padding(
                padding: EdgeInsets.only(
                  left: 26,
                  top: 0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Notifications', style: pageTitles),
                  ],
                ),
              ),
            ),

            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final now = DateTime.now();
                final today = DateTime(now.year, now.month, now.day);
                final yesterday = DateTime(now.year, now.month, now.day - 1);
                bool isDateToday = false;
                bool isDateYesterday = false;
                bool isSameDate = true;
                final String dateString = list[index]['time'];
                final DateTime date = DateTime.parse(dateString);
                final item = list[index];

                if (index == 0) {
                  isSameDate = false;
                } else {
                  final String prevDateString = list[index - 1]['time'];
                  final DateTime prevDate = DateTime.parse(prevDateString);
                  isSameDate = date.isSameDate(prevDate);
                }

                if (date.isSameDate(today)) {
                  isDateToday = true;
                  isDateYesterday = false;
                } else if (date.isSameDate(yesterday)) {
                  isDateToday = false;
                  isDateYesterday = true;
                } else {
                  isDateToday = false;
                  isDateYesterday = false;
                }

                if (index == 0 || !(isSameDate)) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 26.0,
                            top: 10.0,
                            bottom: 0.0,
                          ),
                          child: Row(
                            children: [
                              if (isDateToday)
                                Center(
                                  child: Text(
                                    'Today',
                                    style: classEndTime,
                                  ),
                                )
                              else if (isDateYesterday)
                                Center(
                                  child: Text(
                                    'Yesterday',
                                    style: classEndTime,
                                  ),
                                )
                              else
                                Center(
                                  child: Text(
                                    date.formatDate(),
                                    style: classEndTime,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        PageDivider(leftPadding: 26, rightPadding: 0),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5.0,
                            bottom: 10.0,
                          ),
                          child: Row(
                            children: [
                              UpcomingClassNotification(
                                notificationType: list[index]['type'],
                                notificationDate: date,
                                notificationMessage: list[index]['message'],
                                notificationImage: list[index]['image'],
                              )
                            ],
                          ),
                        )
                      ]);
                } else {
                  return Padding(
                      padding: EdgeInsets.only(
                        bottom: 10.0,
                      ),
                      child: UpcomingClassNotification(
                        notificationType: list[index]['type'],
                        notificationDate: date,
                        notificationMessage: list[index]['message'],
                        notificationImage: list[index]['image'],
                      ));
                }
              },
              childCount: list.length,
            )),
          ],
        ),
      ),
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
