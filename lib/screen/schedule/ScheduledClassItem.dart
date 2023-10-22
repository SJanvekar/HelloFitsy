import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/feModels/ScheduleModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/schedule/CreateClassSchedule.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../home/components/ClassCardOpen.dart';

class ScheduledClassTile extends StatelessWidget {
  ScheduledClassTile({
    Key? key,
    required this.classItem,
    required this.scheduleItem,
    required this.userInstance,
  }) : super(key: key);

  Class classItem;
  User userInstance;
  BaseSchedule scheduleItem;

//------Widgets------

  //Edit Profile button
  Widget classTimes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Start Time
        Text(
          Jiffy.parse(scheduleItem.startDate.toString())
              .format(pattern: "h:mm a"),
          style: TextStyle(
              color: jetBlack,
              fontFamily: 'SFRounded',
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),

        //End Time
        Text(
          Jiffy.parse(scheduleItem.endDate.toString())
              .format(pattern: "h:mm a"),
          style: TextStyle(
              color: jetBlack40,
              fontFamily: 'SFRounded',
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  //Class Availability - Booked
  Widget classAvailabilityBooked() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (scheduleItem is CancelledSchedule)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: strawberry,
                    ),
                  ),
                ),
              ),
              Text(
                'Cancelled',
                style: TextStyle(
                    color: strawberry,
                    fontFamily: 'SFRounded',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        else if (scheduleItem is UpdatedSchedule)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: (scheduleItem as UpdatedSchedule).isBooked
                          ? emerald
                          : strawberry,
                    ),
                  ),
                ),
              ),
              Text(
                (scheduleItem as UpdatedSchedule).isBooked
                    ? 'Available'
                    : 'Booked',
                style: TextStyle(
                    color: (scheduleItem as UpdatedSchedule).isBooked
                        ? emerald
                        : strawberry,
                    fontFamily: 'SFRounded',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        else if (scheduleItem is Schedule)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: (scheduleItem as Schedule).isBooked
                          ? emerald
                          : strawberry,
                    ),
                  ),
                ),
              ),
              Text(
                (scheduleItem as Schedule).isBooked ? 'Available' : 'Booked',
                style: TextStyle(
                    color: (scheduleItem as Schedule).isBooked
                        ? emerald
                        : strawberry,
                    fontFamily: 'SFRounded',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        if ((scheduleItem as Schedule).recurrence == RecurrenceType.BiWeekly)
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              'Bi-Weekly',
              style: buttonText1Jetblack80,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              (scheduleItem as Schedule).recurrence.name,
              style: buttonText1Jetblack80,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Availability
        classAvailabilityBooked(),

        //Tile
        ListTile(
          //Padding
          contentPadding: EdgeInsets.zero,

          //Tap Function
          onTap: () => {
            print('Classpressed'),
            Navigator.push(
                context,
                PageTransition(
                    child: ClassCardOpen(
                      classItem: classItem,
                      userInstance: userInstance,
                    ),
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 0),
                    reverseDuration: Duration(milliseconds: 0)))
          },

          //Class Image (Leading)
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(classItem.classImageUrl),
                  fit: BoxFit.cover),
            ),
          ),

          //Class Title (Tile Title)
          horizontalTitleGap: 10,
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text(
                  classItem.className,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: jetBlack,
                      fontFamily: 'SFDisplay'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          //Times (Trailing)
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: classTimes(),
          ),
        ),
      ],
    );
  }
}
