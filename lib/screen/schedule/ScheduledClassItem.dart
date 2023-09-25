import 'package:balance/feModels/ClassModel.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../home/components/ClassCardOpen.dart';

class ScheduledClassTile extends StatelessWidget {
  ScheduledClassTile({Key? key, required this.classItem}) : super(key: key);

  Class classItem;

//------Widgets------

//Edit Profile button
  Widget deleteClassButton() {
    return Container(
      alignment: Alignment.center,
      height: 25,
      width: 70,
      decoration: BoxDecoration(
          color: strawberry,
          // border: Border.all(color: shark60),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Text(
          'Delete',
          style: TextStyle(
              color: snow,
              fontFamily: 'SFDisplay',
              fontSize: 13.5,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  //Edit Profile button
  Widget classTimes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Start Time
        Text(
          '10:30 AM',
          style: TextStyle(
              color: jetBlack,
              fontFamily: 'SFRounded',
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),

        //End Time
        Text(
          '12:30 PM',
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
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: ClipOval(
            child: Container(
              height: 10,
              width: 10,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: emerald,
              ),
            ),
          ),
        ),
        Text(
          'Available',
          style: TextStyle(
              color: emerald,
              fontFamily: 'SFRounded',
              fontSize: 14,
              fontWeight: FontWeight.w600),
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
                    child: ClassCardOpen(classItem: classItem),
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
