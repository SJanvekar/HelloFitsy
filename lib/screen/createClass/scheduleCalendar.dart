// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';
import 'dart:collection';

import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassPicture.dart';
import 'package:balance/screen/createClass/createClassSchedule.dart';
import 'package:balance/screen/createClass/createClassTimeList.dart';
import 'package:balance/screen/createClass/createClassType.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/sharedWidgets/classes/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendar();
}

DateTime startTime = DateTime.now();
DateTime endTime = DateTime.utc(2001, 9, 11, 8, 14);

class _ScheduleCalendar extends State<ScheduleCalendar> {
  //variables
  DateTime _focusedDay = DateTime.now();
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarStyle calendarStyle = CalendarStyle(
      selectedDecoration: BoxDecoration(
          color: strawberry60, borderRadius: BorderRadius.circular(10.0)),
      todayTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: strawberry60,
          fontFamily: 'SFDisplay'),
      todayDecoration: BoxDecoration(
        shape: BoxShape.circle,
      ));

  HeaderStyle headerStyle = HeaderStyle(
      titleCentered: true,
      formatButtonVisible: false,
      leftChevronIcon: SvgPicture.asset(
        'assets/icons/arrowLeft.svg',
        height: 15,
      ),
      rightChevronIcon: SvgPicture.asset(
        'assets/icons/arrowRight.svg',
        height: 15,
      ),
      titleTextFormatter: (date, locale) {
        return DateFormat('MMM yyyy').format(date).toString();
      },
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18.0,
          color: jetBlack,
          fontFamily: 'SFDisplay'));

  var calendarBuilder = CalendarBuilders(
    selectedBuilder: (context, date, events) => Padding(
      padding: EdgeInsets.all(8),
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: strawberry60,
          ),
          child: Text(
            date.day.toString(),
            style: TextStyle(color: snow),
          )),
    ),
  );

  var calendarDaysOfWeek = DaysOfWeekStyle(
    weekdayStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15.0,
        color: shark,
        fontFamily: 'SFDisplay'),
    weekendStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15.0,
        color: shark,
        fontFamily: 'SFDisplay'),
    dowTextFormatter: (date, locale) {
      // return date.toString().toUpperCase();
      return DateFormat.E(locale).format(date).toString().toUpperCase();
    },
  );

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // Update values in a Set
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
  }

  void displayTimePicker(bool isStartDateLabel) {
    DateTime initialTime = isStartDateLabel ? startTime : endTime;

    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: snow,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                      child: Text(
                    "Select Time",
                    style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              Container(
                color: snow,
                child: Divider(
                  thickness: 2,
                  color: shark,
                  indent: 5,
                  endIndent: 5,
                ),
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.25,
                color: snow,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  onDateTimeChanged: (value) {
                    if (isStartDateLabel) {
                      if (value != null && value != startTime) {
                        setState(() {
                          startTime = value;
                        });
                      }
                    } else {
                      if (value != null && value != endTime) {
                        setState(() {
                          endTime = value;
                        });
                      }
                    }
                  },
                  initialDateTime: initialTime,
                  minimumYear: 2019,
                  maximumYear: 2050,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,

      //AppBar
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: TextButton(
                onPressed: () {
                  print("Back");
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => CreateClassType()));
                },
                child: Text("Back", style: logInPageNavigationButtons),
              ),
            ),
          ],
        ),
      ),

      //Body
      body: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pageTitle(),

            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 35),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.utc(2050, 12, 31),
                  focusedDay: DateTime.now(),
                  calendarFormat: CalendarFormat.month,
                  calendarStyle: calendarStyle,
                  headerStyle: headerStyle,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  calendarBuilders: calendarBuilder,
                  selectedDayPredicate: (day) {
                    return _selectedDays.contains(day);
                  },
                  onDaySelected: _onDaySelected,
                  daysOfWeekStyle: calendarDaysOfWeek,
                ),
              ),
            ),

            selectTime(),

            //Slider Stuff
            Padding(
              padding: const EdgeInsets.only(top: 36.0, bottom: 45),
              child: GestureDetector(
                  child: LoginFooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: "Add time",
                  ),
                  onTap: () {
                    print(widget.classTemplate.className);
                    Schedule newSchedule = Schedule(
                        dates: _selectedDays,
                        startTime: startTime,
                        endTime: endTime);
                    widget.classTemplate.classTimes.add(newSchedule);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateClassSchedule(
                            classTemplate: widget.classTemplate)));
                  }),
            ),
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }

  Widget selectTime() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              "Start date",
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: bone,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
              child: Text(
                DateFormat.jm().format(startTime),
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              displayTimePicker(true);
            },
          ),
          const Padding(
            padding: EdgeInsets.only(right: 10, left: 15),
            child: Text(
              "End date",
              style: TextStyle(
                fontFamily: 'SFDisplay',
                color: jetBlack,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: bone,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
              child: Text(
                DateFormat.jm().format(endTime),
                style: TextStyle(
                  fontFamily: 'SFDisplay',
                  color: jetBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: () {
              displayTimePicker(false);
            },
          ),
        ],
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Container(
        padding: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(color: snow),
        child: Text(
          'Select a date and time',
          style: logInPageTitle,
          textAlign: TextAlign.center,
        )),
  );
}

Widget _buildEventsMarker(DateTime date) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: strawberry60,
        ),
        child: Text(
          date.day.toString(),
          style: TextStyle(color: Colors.white),
        )),
  );
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
