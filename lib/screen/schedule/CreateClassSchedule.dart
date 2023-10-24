// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';
import 'dart:collection';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/Constants.dart';
import 'package:balance/Requests/ClassRequests.dart';
import 'package:balance/Requests/ScheduleRequests.dart';
import 'package:balance/example.dart';
import 'package:balance/feModels/ScheduleModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/CreateClassTimeList.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/components/ClassCardOpen.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/screen/schedule/ScheduledClassItem.dart';
import 'package:balance/sharedWidgets/BodyButton.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:balance/sharedWidgets/pageDivider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:table_calendar/table_calendar.dart';

//  -------------------------------------------------------- Calendar Widget ------------------------------------------------------------- //

class ScheduleCalendar extends StatefulWidget {
  ScheduleCalendar({
    Key? key,
    required this.userInstance,
  }) : super(key: key);

  User userInstance;
  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendar();
}

//Global Variables

DateTime startTime = DateTime.now();
DateTime endTime = DateTime.now().add(Duration(hours: 1));
RecurrenceType recurrenceType = RecurrenceType.None;
bool isClassSelected = false;
String selectedClassID = '';
String selectedScheduleID = '';
DateTime selectedStartTime = DateTime.now();
DateTime selectedEndTime = DateTime.now();
RecurrenceType selectedRecurrenceType = RecurrenceType.None;
String selectedClassName = '';
String selectedClassImageUrl = '';
Map<BaseSchedule, Class> scheduledClassesMap = {};
List<Class> allClasses = [];
List<String> trainerIDList = [];
bool isEditMode = false;
DateTime _focusedDay = DateTime.now();
List<UpdatedSchedule> updatedSelectedDayClassTimeInstances = [];
List<CancelledSchedule> cancelledSelectedDayClassTimeInstances = [];

//Event Changer Enum

enum EventChanger { single, all }

//Class Placeholder until a class gets selected
Widget selectClassPlaceholder() {
  return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1.5, color: shark60)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: shark60, borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Select a class',
                style: TextStyle(
                    color: shark60,
                    fontFamily: 'SFDisplay',
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ));
}

//Selected Class Item
Widget selectClassListItem(image, className) {
  return Row(
    children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image,
                )),
            borderRadius: BorderRadius.circular(10)),
      ),
      Flexible(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            className,
            style: TextStyle(
              fontFamily: 'SFDisplay',
              color: jetBlack,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      )
    ],
  );
}

class _ScheduleCalendar extends State<ScheduleCalendar> {
  //Event Changer variables
  EventChanger? _character = EventChanger.single;

  //On load function
  void initState() {
    super.initState();

    _focusedDay = DateTime.now();
    //Clear all lists and maps
    allClasses.clear();
    //Set today's date as selected day
    _selectedDays.add(_focusedDay);

    trainerIDList.clear();
    //Add the userID to trainerIDList
    trainerIDList.add(widget.userInstance.userID);

    //Get classes for this trainer
    getClassFeed(trainerIDList);
  }

  //Functions -----------------------------------------------------------------

  //Get Classes for the trainer
  void getClassFeed(List<String> trainerID) async {
    ClassRequests().getClass(trainerID).then((val) async {
      if (val.data['success']) {
        print('successful get class feed');
        (val.data['classArray'] as List<dynamic>).forEach((element) {
          allClasses.add(Class.fromJson(element));
        });
      } else {
        print('error get class feed: ${val.data['msg']}');
      }
      determineDaySchedule(allClasses, _selectedDays);
      setState(() {});
    });
  }

  //Check if a class should be scheduled based on recurrence
  void shouldScheduleClass(Class classItem, DateTime selectedDay) {
    classItem.classTimes.sort((a, b) => a.startDate.compareTo(b.startDate));

    for (Schedule classTime in classItem.classTimes) {
      final DateTime startDate = classTime.startDate;
      final RecurrenceType recurrence = classTime.recurrence;
      final String scheduleID = classTime.scheduleID;

      //Find the difference between the currently selected date and the start date
      int daysBetween(DateTime from, DateTime to) {
        from = DateTime(from.year, from.month, from.day);
        to = DateTime(to.year, to.month, to.day);
        return (to.difference(from).inHours / 24).round();
      }

      final int dateDifference = daysBetween(startDate, selectedDay);
      //Check if there are any updated class schedules for the associated on the selected date
      updatedSelectedDayClassTimeInstances.clear();
      updatedSelectedDayClassTimeInstances =
          classItem.updatedClassTimes.where((updatedClassTime) {
        final DateTime updatedClassStartDate = updatedClassTime.startDate;
        return updatedClassStartDate.day == selectedDay.day &&
            updatedClassStartDate.month == selectedDay.month &&
            updatedClassStartDate.year == selectedDay.year &&
            updatedClassTime.scheduleReference == classTime.scheduleID;
      }).toList();

      //Check if there are any cancelled class schedules for the associated schedule on the selected date
      cancelledSelectedDayClassTimeInstances.clear();
      cancelledSelectedDayClassTimeInstances =
          classItem.cancelledClassTimes.where((cancelledClassTime) {
        final DateTime cancelledClassStartDate = cancelledClassTime.startDate;
        return cancelledClassStartDate.day == selectedDay.day &&
            cancelledClassStartDate.month == selectedDay.month &&
            cancelledClassStartDate.year == selectedDay.year &&
            cancelledClassTime.scheduleReference == classTime.scheduleID;
      }).toList();

      if (cancelledSelectedDayClassTimeInstances.isEmpty) {
        //Check Updated selected days
        if (updatedSelectedDayClassTimeInstances.isNotEmpty) {
          scheduledClassesMap[updatedSelectedDayClassTimeInstances[0]] =
              classItem;
        } else {
          //First check if today is the original start date
          if (startDate.day == selectedDay.day &&
              startDate.month == selectedDay.month &&
              startDate.year == selectedDay.year) {
            scheduledClassesMap[classTime] = classItem;
            continue;
          }

          //Second check the recurrance if it is anything other than none (None is handled with the above check)
          if (recurrence == RecurrenceType.Daily &&
              dateDifference % 1 == 0 &&
              dateDifference != 0) {
            scheduledClassesMap[classTime] = classItem;
            continue;
          } else if (recurrence == RecurrenceType.Weekly &&
              dateDifference % 7 == 0 &&
              dateDifference != 0) {
            scheduledClassesMap[classTime] = classItem;
            continue;
          } else if (recurrence == RecurrenceType.BiWeekly &&
              dateDifference % 14 == 0 &&
              dateDifference != 0) {
            scheduledClassesMap[classTime] = classItem;
            continue;
          } else if (recurrence == RecurrenceType.Monthly &&
              startDate.month != selectedDay.month &&
              startDate.day == selectedDay.day) {
            scheduledClassesMap[classTime] = classItem;
            continue;
          } else if (recurrence == RecurrenceType.Yearly &&
              startDate.year != selectedDay.year &&
              startDate.month == selectedDay.month &&
              startDate.day == selectedDay.day) {
            scheduledClassesMap[classTime] = classItem;
            continue;
          }
        }
      } else {
        //Do nothing

        //Deprecated
        // scheduledClassesMap[cancelledSelectedDayClassTimeInstances[0]] =
        //     classItem;
        // cancelledSelectedDayClassTimeInstances[0].isCancelled = true;
      }
    }
  }

//Schedule list organizer
  Map<BaseSchedule, Class> sortedClassScheduleMap(
      Map<BaseSchedule, Class> scheduledClassesMapRaw) {
    // Get the map entries and sort them based on keys (DateTime objects).
    final sortedEntries = scheduledClassesMap.entries.toList()
      ..sort((a, b) => a.key.startDate.hour.compareTo(b.key.startDate.hour));

    // Create a new map from the sorted entries.
    final sortedMap = Map.fromEntries(sortedEntries);

    return sortedMap;
  }

//Determine Today's Schedule
  void determineDaySchedule(
      List<Class> allClasses, Set<DateTime> selectedDays) {
    scheduledClassesMap.clear();

    for (var selectedDay in selectedDays) {
      for (var classItem in allClasses) {
        shouldScheduleClass(classItem, selectedDay);

        //Organize classes by date
        scheduledClassesMap = sortedClassScheduleMap(scheduledClassesMap);
      }
    }
  }

  void addClassSchedule() async {
    ScheduleRequests()
        .addClassSchedule(
      selectedClassID,
      selectedStartTime,
      selectedEndTime,
      recurrenceType.name,
    )
        .then((val) {
      if (val.data['success']) {
        print("Successfully added class schedule");
        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
      } else {
        print("Saving class schedule failed: ${val.data['msg']}");
      }
    });
  }

  void changeClassSchedule() async {
    ScheduleRequests()
        .changeClassSchedule(
      selectedClassID,
      selectedScheduleID,
      selectedStartTime,
      selectedEndTime,
      selectedRecurrenceType.name,
    )
        .then((val) {
      if (val.data['success']) {
        print("Successfully edited class schedules");

        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
      } else {
        print("Saving class schedules edit failed: ${val.data['msg']}");
      }
    });
  }

  void changeClassScheduleSingle() async {
    ScheduleRequests()
        .addUpdatedClassSchedule(selectedClassID, selectedScheduleID,
            selectedStartTime, selectedEndTime)
        .then((val) {
      if (val.data['success']) {
        print("Successfully added an instance of updated class schedules");

        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
      } else {
        print(
            "Adding updated class schedule instance edit failed: ${val.data['msg']}");
      }
    });
  }

  void deleteClassSchedule() async {
    ScheduleRequests()
        .removeClassSchedule(
      selectedClassID,
      selectedScheduleID,
    )
        .then((val) {
      if (val.data['success']) {
        print("Successfully deleted class schedules");
        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
      } else {
        print("Deleting class schedules failed: ${val.data['msg']}");
      }
    });
  }

  void removeUpdatedSchedule(String? newScheduleID) async {
    ScheduleRequests()
        .removeUpdatedClassSchedule(
      selectedClassID,
      selectedScheduleID,
    )
        .then((val) {
      if (val.data['success']) {
        print("Successfully deleted updated class schedule");
        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
        selectedScheduleID = newScheduleID ?? '';
        if (_character == EventChanger.single) {
          cancelClassSchedule();
        } else {
          deleteClassSchedule();
        }
      } else {
        print("Deleting updated class schedules failed: ${val.data['msg']}");
      }
    });
  }

  void cancelClassSchedule() async {
    ScheduleRequests()
        .addCancelledClassSchedule(selectedClassID, selectedScheduleID,
            selectedStartTime, selectedEndTime)
        .then((val) {
      if (val.data['success']) {
        print("Successfully deleted selected class schedule");
        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
      } else {
        print("Deleting selected class schedule failed: ${val.data['msg']}");
      }
    });
  }

  void rescheduleClassSchedule() async {
    ScheduleRequests()
        .removeCancelledClassSchedule(
      selectedClassID,
      selectedScheduleID,
    )
        .then((val) {
      if (val.data['success']) {
        print("Successfully reinstated selected class schedule");
        allClasses.clear();
        //Get classes for this trainer
        getClassFeed(trainerIDList);
      } else {
        print("Reinstating selected class schedule failed: ${val.data['msg']}");
      }
    });
  }

  //Edit schedule confirmation
  eventSingleOrFutureUpdate(context, StateSetter baseSetState) {
    return StatefulBuilder(builder: (context, eventChangerState) {
      return Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                  color: jetBlack20, offset: Offset(0, 5), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0),
              child: Text(
                'Make changes for this event or all events?',
                style: disclaimerTitle,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: const Text('This event', style: profileBodyTextFont),
              leading: Radio<EventChanger>(
                value: EventChanger.single,
                groupValue: _character,
                onChanged: (EventChanger? value) {
                  eventChangerState(() {
                    _character = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('All events', style: profileBodyTextFont),
              leading: Radio<EventChanger>(
                value: EventChanger.all,
                groupValue: _character,
                onChanged: (EventChanger? value) {
                  eventChangerState(() {
                    _character = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
                child: BodyButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: 'Done'),
                //Log out function
                onTap: () {
                  HapticFeedback.selectionClick();
                  //Set Start time & End time to focused day (Since we are only changing this event)
                  selectedStartTime = DateTime(
                      _focusedDay.year,
                      _focusedDay.month,
                      _focusedDay.day,
                      startTime.hour,
                      startTime.minute);
                  selectedEndTime = DateTime(
                      _focusedDay.year,
                      _focusedDay.month,
                      _focusedDay.day,
                      endTime.hour,
                      endTime.minute);
                  //Check if edit mode
                  if (isEditMode) {
                    if (_character == EventChanger.single) {
                      //Call update class schedule (updated class)
                      changeClassScheduleSingle();
                    } else {
                      changeClassSchedule();
                    }
                  } else {
                    if (_character == EventChanger.single) {
                      //Cancelling a single instance of schedule
                      UpdatedSchedule? matchingSchedule;
                      if (updatedSelectedDayClassTimeInstances
                          .any((scheduleItem) {
                        if (scheduleItem.scheduleID == selectedScheduleID) {
                          matchingSchedule = scheduleItem;
                          return true;
                        }
                        return false;
                      })) {
                        removeUpdatedSchedule(
                            matchingSchedule!.scheduleReference);
                      } else {
                        cancelClassSchedule();
                      }
                    } else {
                      //Cancelling a single instance of schedule
                      UpdatedSchedule? matchingSchedule;
                      if (updatedSelectedDayClassTimeInstances
                          .any((scheduleItem) {
                        if (scheduleItem.scheduleID == selectedScheduleID) {
                          matchingSchedule = scheduleItem;
                          return true;
                        }
                        return false;
                      })) {
                        removeUpdatedSchedule(
                            matchingSchedule!.scheduleReference);
                      } else {
                        deleteClassSchedule();
                      }
                    }
                  }
                  Navigator.of(context).pop();
                }),
          ],
        ),
      );
    });
  }

  //Delete schedule confirmation
  contentBoxDelete(context, baseScreenState) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: jetBlack20, offset: Offset(0, 5), blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Are you sure you want to delete this schedule?',
              style: disclaimerTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: shark60,
                          textColor: jetBlack,
                          buttonText: 'Cancel'),
                      onTap: () => {
                            Navigator.of(context).pop(),
                          }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: strawberry,
                          textColor: snow,
                          buttonText: 'Delete'),
                      //Log out function
                      onTap: () => {
                            HapticFeedback.selectionClick(),
                            isEditMode = false,
                            Navigator.of(context).pop(),
                            //Show all or future events selector
                            showDialog(
                                context: context,
                                builder: (BuildContext eventChangerContext) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    child: eventSingleOrFutureUpdate(
                                        eventChangerContext, setState),
                                  );
                                }),
                          }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Cancel schedule confirmation
  contentBoxCancel(context, baseScreenState) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: jetBlack20, offset: Offset(0, 5), blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Are you sure you want to cancel this session?',
                style: disclaimerTitle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: shark60,
                          textColor: jetBlack,
                          buttonText: 'Cancel'),
                      onTap: () => {
                            Navigator.of(context).pop(),
                          }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: strawberry,
                          textColor: snow,
                          buttonText: 'Confirm'),
                      //Log out function
                      onTap: () => {
                            HapticFeedback.selectionClick(),
                            //Set Start time & End time to focused day (Since we are only changing this event)
                            selectedStartTime = DateTime(
                                _focusedDay.year,
                                _focusedDay.month,
                                _focusedDay.day,
                                selectedStartTime.hour,
                                selectedStartTime.minute),
                            selectedEndTime = DateTime(
                                _focusedDay.year,
                                _focusedDay.month,
                                _focusedDay.day,
                                selectedEndTime.hour,
                                selectedEndTime.minute),
                            cancelClassSchedule(),
                            Navigator.of(context).pop(),
                            setState(() {}),
                          }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Reschedule confirmation // Deprecated
  contentBoxReschedule(context, baseScreenState) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: jetBlack20, offset: Offset(0, 5), blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Are you sure you want to reschedule this session?',
                style: disclaimerTitle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: shark60,
                          textColor: jetBlack,
                          buttonText: 'Cancel'),
                      onTap: () => {
                            Navigator.of(context).pop(),
                          }),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                      child: BodyButton(
                          buttonColor: strawberry,
                          textColor: snow,
                          buttonText: 'Reschedule'),
                      //Log out function
                      onTap: () => {
                            HapticFeedback.selectionClick(),
                            //Set Start time & End time to focused day (Since we are only changing this event)
                            selectedStartTime = DateTime(
                                _focusedDay.year,
                                _focusedDay.month,
                                _focusedDay.day,
                                selectedStartTime.hour,
                                selectedStartTime.minute),
                            selectedEndTime = DateTime(
                                _focusedDay.year,
                                _focusedDay.month,
                                _focusedDay.day,
                                selectedEndTime.hour,
                                selectedEndTime.minute),
                            rescheduleClassSchedule(),
                            Navigator.of(context).pop(),
                            setState(() {}),
                          }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Calendar Declarations

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarStyle calendarStyle = CalendarStyle(
      selectedDecoration: BoxDecoration(
          color: strawberry, borderRadius: BorderRadius.circular(10.0)),
      todayTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: strawberry,
          fontFamily: 'SFDisplay'),
      defaultTextStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: jetBlack,
          fontFamily: 'SFDisplay'),
      todayDecoration: BoxDecoration(
        shape: BoxShape.circle,
      ));

  HeaderStyle headerStyle = HeaderStyle(
      titleCentered: false,
      formatButtonVisible: false,
      headerPadding: EdgeInsets.only(bottom: 20, left: 10),
      leftChevronVisible: false,
      rightChevronVisible: false,
      leftChevronIcon: SvgPicture.asset(
        'assets/icons/generalIcons/arrowLeft.svg',
        height: 15,
      ),
      rightChevronIcon: SvgPicture.asset(
        'assets/icons/generalIcons/arrowRight.svg',
        height: 15,
      ),
      titleTextFormatter: (date, locale) {
        return DateFormat('MMM yyyy').format(date).toString();
      },
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
          color: jetBlack80,
          fontFamily: 'SFDisplay'));

  var calendarBuilder = CalendarBuilders(
    selectedBuilder: (context, date, events) => Padding(
      padding: EdgeInsets.all(8),
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: strawberry,
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
        color: jetBlack,
        fontFamily: 'SFDisplay'),
    weekendStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15.0,
        color: jetBlack40,
        fontFamily: 'SFDisplay'),
    dowTextFormatter: (date, locale) {
      // return date.toString().toUpperCase();
      return DateFormat.E(locale).format(date).toString();
    },
  );

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = selectedDay;
      _selectedDays.clear();
      _selectedDays.add(selectedDay);

      determineDaySchedule(allClasses, _selectedDays);

      //Set start and end time to date selected
      startTime =
          DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
      endTime = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    });
  }

  void displayClassAndTimePicker(StateSetter baseSetState) {
    String formatdates(DateTime dateToFormat) {
      String formattedDate = dateToFormat.toString();
      return Jiffy.parse(formattedDate).format(pattern: "MMMM do");
    }

    String formatTimes(DateTime dateToFormat) {
      String formattedDate = dateToFormat.toString();
      return Jiffy.parse(formattedDate).format(pattern: "h:mm a");
    }

    showCupertinoModalPopup(
        semanticsDismissible: true,
        barrierDismissible: true,
        barrierColor: jetBlack60,
        context: context,
        builder: (BuildContext builder) {
          return StatefulBuilder(
            builder:
                (BuildContext context, StateSetter setModalSheetPage2State) {
              String originalStartDateFormatted = formatdates(startTime);
              String currentEventDateFormatted = formatdates(_focusedDay);
              String startTimeFormatted = formatTimes(startTime);
              String endTimeFormatted = formatTimes(endTime);

              return Material(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    decoration: BoxDecoration(
                        color: snow, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 26.0, right: 26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                                bottom: 15,
                              ),
                              child: ClipOval(
                                child: Container(
                                  color: jetBlack40,
                                  height: 25,
                                  width: 25,
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/generalIcons/exit.svg',
                                      color: snow,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () => {Navigator.of(context).pop()},
                          ),
                          Expanded(
                            child: CustomScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              slivers: [
                                MultiSliver(children: [
                                  if (isClassSelected == false)
                                    GestureDetector(
                                      child: selectClassPlaceholder(),
                                      onTap: () {
                                        displayClassPicker(
                                            setModalSheetPage2State,
                                            trainerIDList,
                                            context);
                                      },
                                    )
                                  else
                                    GestureDetector(
                                      child: selectClassListItem(
                                          selectedClassImageUrl,
                                          selectedClassName),
                                      onTap: () {
                                        displayClassPicker(
                                            setModalSheetPage2State,
                                            trainerIDList,
                                            context);
                                      },
                                    ),
                                  SizedBox(height: 25),
                                  Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: bone80,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(0),
                                            bottomLeft: Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20.0),
                                                      child: Icon(
                                                        HelloFitsy.calendar,
                                                        size: 21.5,
                                                        color: jetBlack,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Text(
                                                      'Class date',
                                                      style:
                                                          settingsDefaultHeaderText,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20.0),
                                                    child: Text(
                                                      currentEventDateFormatted,
                                                      style: popUpMenuText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      PageDivider(
                                        leftPadding: 0,
                                        rightPadding: 0,
                                      ),
                                      GestureDetector(
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: bone80,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(0),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/generalIcons/clock.svg',
                                                          height: 21.5,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          'Start time',
                                                          style:
                                                              settingsDefaultHeaderText,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 20.0),
                                                        child: Text(
                                                          startTimeFormatted,
                                                          style: popUpMenuText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            displayTimePicker(
                                                false,
                                                true,
                                                setModalSheetPage2State,
                                                context);
                                          }),
                                      PageDivider(
                                        leftPadding: 0,
                                        rightPadding: 0,
                                      ),
                                      GestureDetector(
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: bone80,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(20),
                                                bottomLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20.0),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/generalIcons/clock.svg',
                                                          height: 21.5,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          'End time',
                                                          style:
                                                              settingsDefaultHeaderText,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 20.0),
                                                        child: Text(
                                                          endTimeFormatted,
                                                          style: popUpMenuText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            displayTimePicker(
                                                false,
                                                false,
                                                setModalSheetPage2State,
                                                context);
                                          }),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  RecurrencePopUpMenu(
                                    modalSetState: setModalSheetPage2State,
                                    child: Container(
                                      key: GlobalKey(),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: bone80,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/generalIcons/repeat.svg',
                                                    height: 21.5,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Text(
                                                    'Repeat',
                                                    style:
                                                        settingsDefaultHeaderText,
                                                  ),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: SizedBox(
                                                    height: 60,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          (recurrenceType ==
                                                                  RecurrenceType
                                                                      .BiWeekly)
                                                              ? 'Bi-Weekly'
                                                              : recurrenceType
                                                                  .name,
                                                          style:
                                                              settingsDefaultSelectionText,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 5.0),
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/icons/generalIcons/arrowRight.svg',
                                                            height: 15,
                                                            color: jetBlack60,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  isEditMode
                                      ? GestureDetector(
                                          child: FooterButton(
                                              buttonColor: ocean,
                                              textColor: snow,
                                              buttonText: 'Save Changes'),
                                          onTap: () {
                                            selectedStartTime = startTime;
                                            selectedEndTime = endTime;
                                            selectedRecurrenceType =
                                                recurrenceType;
                                            // changeClassSchedule();
                                            Navigator.of(context).pop();
                                            //Update _character to eventChanger.single
                                            _character = EventChanger.single;
                                            //Show all or future events selector
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                    eventChangerContext) {
                                                  return Dialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child:
                                                        eventSingleOrFutureUpdate(
                                                            eventChangerContext,
                                                            baseSetState),
                                                  );
                                                });
                                          },
                                        )
                                      : GestureDetector(
                                          child: FooterButton(
                                              buttonColor: ocean,
                                              textColor: snow,
                                              buttonText: 'Add'),
                                          onTap: () {
                                            baseSetState(() {
                                              selectedStartTime = DateTime(
                                                  _focusedDay.year,
                                                  _focusedDay.month,
                                                  _focusedDay.day,
                                                  startTime.hour,
                                                  startTime.minute);
                                              selectedEndTime = DateTime(
                                                  _focusedDay.year,
                                                  _focusedDay.month,
                                                  _focusedDay.day,
                                                  endTime.hour,
                                                  endTime.minute);
                                              addClassSchedule();
                                              Navigator.of(context).pop();
                                              getClassFeed(trainerIDList);
                                            });
                                          },
                                        )
                                ])
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          );
        });
  }

  //Time Picker Modal Sheet
  void displayTimePicker(
      bool isDate, bool isStartDateLabel, StateSetter modalsetState, context) {
    DateTime initialTime = isStartDateLabel ? startTime : endTime;
    showCupertinoModalPopup(
        barrierColor: jetBlack60,
        context: context,
        builder: (BuildContext builder) {
          return Container(
            decoration: BoxDecoration(
              color: snow,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).copyWith().size.height * 0.45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 20.0,
                  ),
                  child: Center(
                      child: Text(
                    isDate ? "Select a date" : "Select a time",
                    style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
                Container(
                  height: MediaQuery.of(context).copyWith().size.height * 0.2,
                  child: CupertinoDatePicker(
                    mode: isDate
                        ? CupertinoDatePickerMode.date
                        : CupertinoDatePickerMode.time,
                    onDateTimeChanged: (value) {
                      if (isDate) {
                        setState(() {
                          startTime = DateTime(value.year, value.month,
                              value.day, startTime.hour, startTime.minute);
                          endTime = DateTime(value.year, value.month, value.day,
                              endTime.hour, endTime.minute);
                        });
                      } else {
                        if (isStartDateLabel) {
                          if (value != startTime) {
                            setState(() {
                              startTime = value;
                            });
                          }
                        } else {
                          if (value != endTime) {
                            setState(() {
                              endTime = value;

                              //Add checks for if End Date is before start date
                            });
                          }
                        }
                      }
                    },
                    initialDateTime: initialTime,
                    minimumYear: 2019,
                    maximumYear: 2050,
                  ),
                ),
                SizedBox(height: 50.0),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 26.0, right: 26.0, bottom: 20),
                    child: FooterButton(
                        buttonColor: bone,
                        textColor: jetBlack,
                        buttonText: 'Done'),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    modalsetState(() {});
                  },
                )
              ],
            ),
          );
        });
  }

  //Class Picker Modal Sheet
  void displayClassPicker(
      StateSetter modalsetState, List<String> trainerID, context) {
    showCupertinoModalPopup(
        barrierColor: jetBlack60,
        context: context,
        builder: (BuildContext builder) {
          return Container(
            decoration: BoxDecoration(
              color: snow,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).copyWith().size.height * 0.57,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        bottom: 15,
                      ),
                      child: ClipOval(
                        child: Container(
                          color: jetBlack40,
                          height: 25,
                          width: 25,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: SvgPicture.asset(
                              'assets/icons/generalIcons/exit.svg',
                              color: snow,
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    child: Text(
                      "Select a class",
                      style: TextStyle(
                        fontFamily: 'SFDisplay',
                        color: jetBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      itemCount: allClasses.length,
                      itemBuilder: (context, index) {
                        final classItem = allClasses[index];
                        return GestureDetector(
                          child: Column(
                            children: [
                              selectClassListItem(
                                  classItem.classImageUrl, classItem.className),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                          onTap: () {
                            modalsetState(() {
                              isClassSelected = true;
                              selectedClassName = classItem.className;
                              selectedClassImageUrl = classItem.classImageUrl;
                              selectedClassID = classItem.classID;
                            });

                            HapticFeedback.lightImpact();
                            Navigator.of(context).pop();
                          },
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).size.height * 0.028;
    var appHeaderSize = MediaQuery.of(context).size.height * 0.0775;
    var searchBarWidth = MediaQuery.of(context).size.width - (26 * 2) - 50;

    return Scaffold(
        backgroundColor: snow,

        //AppBar
        appBar: AppBar(
          toolbarHeight: 5,
          elevation: 0,
          backgroundColor: snow,
        ),

        //Body
        body: CustomScrollView(
          slivers: [
            //AppBar Sliver
            SliverAppBar(
                floating: true,
                pinned: false,
                toolbarHeight: appHeaderSize,
                elevation: 0,
                backgroundColor: snow,
                automaticallyImplyLeading: false,
                stretch: true,

                //Title
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(
                    left: 26,
                    top: paddingTop,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Class schedule', style: pageTitles),
                    ],
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 26.0),
                    child: GestureDetector(
                      child: SvgPicture.asset(
                        'assets/icons/generalIcons/create.svg',
                        color: jetBlack,
                        height: 22,
                        width: 22,
                      ),
                      onTap: () {
                        isClassSelected = false;
                        isEditMode = false;
                        startTime = DateTime.now();
                        endTime = DateTime.now().add(Duration(hours: 1));
                        recurrenceType = RecurrenceType.None;
                        displayClassAndTimePicker(setState);
                      },
                    ),
                  )
                ]),
            MultiSliver(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 25, right: 25, top: 10),
                          child: TableCalendar(
                            firstDay: DateTime.now(),
                            lastDay: DateTime.utc(2075, 12, 31),
                            focusedDay: _focusedDay,
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

                      //Scheduled classes for _selectdDays (Date selected)
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: 20, left: 26.0, right: 26.0),
                            itemCount: scheduledClassesMap.length,
                            itemBuilder: (context, index) {
                              final scheduleItem =
                                  scheduledClassesMap.keys.elementAt(index);
                              //If an exception is thrown here, something went horribly wrong
                              final classItem =
                                  scheduledClassesMap[scheduleItem]!;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GestureDetector(
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                        extentRatio: 0.65,
                                        motion: ScrollMotion(),
                                        children: [
                                          //Edit Schedule
                                          SlidableAction(
                                            // An action can be bigger than the others.
                                            flex: 2,
                                            onPressed: (BuildContext context) {
                                              selectedClassID =
                                                  classItem.classID;
                                              selectedClassImageUrl =
                                                  classItem.classImageUrl;
                                              selectedClassName =
                                                  classItem.className;
                                              selectedScheduleID =
                                                  scheduleItem.scheduleID;
                                              isEditMode = true;
                                              isClassSelected = true;
                                              if (scheduleItem is Schedule) {
                                                recurrenceType =
                                                    scheduleItem.recurrence;
                                              }
                                              startTime =
                                                  scheduleItem.startDate;
                                              endTime = scheduleItem.endDate;
                                              displayClassAndTimePicker(
                                                  setState);
                                            },
                                            backgroundColor: bone,
                                            foregroundColor: jetBlack,
                                            icon: Icons.edit,
                                            label: 'Edit',
                                          ),
                                          SlidableAction(
                                            flex: 2,
                                            onPressed: (BuildContext context) {
                                              isEditMode = false;
                                              selectedClassID =
                                                  classItem.classID;
                                              selectedScheduleID =
                                                  scheduleItem.scheduleID;
                                              selectedStartTime =
                                                  scheduleItem.startDate;
                                              selectedEndTime =
                                                  scheduleItem.endDate;
                                              if (scheduleItem is Schedule) {
                                                selectedRecurrenceType =
                                                    scheduleItem.recurrence;
                                              }
                                              selectedClassName =
                                                  classItem.className;
                                              selectedClassImageUrl =
                                                  classItem.classImageUrl;
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                      contentBoxContext) {
                                                    return Dialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      elevation: 0,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: contentBoxDelete(
                                                          contentBoxContext,
                                                          setState),
                                                    );
                                                  });
                                            },
                                            backgroundColor: strawberry,
                                            foregroundColor: snow,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                        ]),
                                    child: ScheduledClassTile(
                                      classItem: classItem,
                                      scheduleItem: scheduleItem,
                                      userInstance: widget.userInstance,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ])
          ],
        ));
  }

  // Widget selectTime() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const Padding(
  //           padding: EdgeInsets.only(right: 10),
  //           child: Text(
  //             "Start date",
  //             style: TextStyle(
  //               fontFamily: 'SFDisplay',
  //               color: jetBlack,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w400,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         GestureDetector(
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: bone,
  //                 borderRadius: BorderRadius.all(Radius.circular(20))),
  //             padding: EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
  //             child: Text(
  //               DateFormat.jm().format(startTime),
  //               style: TextStyle(
  //                 fontFamily: 'SFDisplay',
  //                 color: jetBlack,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //           onTap: () {
  //             displayTimePicker(true, setState, context);
  //           },
  //         ),
  //         const Padding(
  //           padding: EdgeInsets.only(right: 10, left: 15),
  //           child: Text(
  //             "End date",
  //             style: TextStyle(
  //               fontFamily: 'SFDisplay',
  //               color: jetBlack,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w400,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ),
  //         GestureDetector(
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 color: bone,
  //                 borderRadius: BorderRadius.all(Radius.circular(20))),
  //             padding: EdgeInsets.only(left: 18, right: 18, top: 6, bottom: 6),
  //             child: Text(
  //               DateFormat.jm().format(endTime),
  //               style: TextStyle(
  //                 fontFamily: 'SFDisplay',
  //                 color: jetBlack,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ),
  //           onTap: () {
  //             displayTimePicker(false, setState, context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

Widget _buildEventsMarker(DateTime date) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: strawberry,
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

class RecurrencePopUpMenu extends StatefulWidget {
  final Widget child;
  RecurrencePopUpMenu(
      {Key? key, required this.child, required this.modalSetState})
      : assert(child.key != null),
        super(key: key);

  StateSetter modalSetState;

  @override
  State<RecurrencePopUpMenu> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RecurrencePopUpMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPopUpMenu(widget.modalSetState),
      child: widget.child,
    );
  }

  void _showPopUpMenu(StateSetter modalSetState) {
    showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          //Find Renderbox object
          RenderBox renderBox = (widget.child.key as GlobalKey)
              .currentContext
              ?.findRenderObject() as RenderBox;

          Offset position = renderBox.localToGlobal(Offset.zero);

          return Stack(
            children: [
              Positioned(
                left: MediaQuery.of(context).size.width - 250,
                right: (MediaQuery.of(context).size.width - position.dx) -
                    renderBox.size.width,
                top: position.dy - 245,
                child: PopUpMenuContents(
                  modalSetState: modalSetState,
                ),
              )
            ],
          );
        });
  }
}

class PopUpMenuContents extends StatefulWidget {
  PopUpMenuContents({Key? key, required this.modalSetState}) : super(key: key);

  StateSetter modalSetState;

  @override
  State<PopUpMenuContents> createState() => _PopUpMenuContentsState();
}

class _PopUpMenuContentsState extends State<PopUpMenuContents> {
  @override
  void initState() {
    super.initState();
    //Call bolding/selection trait function here (Bold selected option)
  }

  @override
  //HARD CODED - MUST CHANGE
  //HARD CODED RECURRANCE TYPES
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.maxFinite,
        decoration:
            BoxDecoration(color: snow, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Stack(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'None',
                    style: popUpMenuText,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    color: Colors.transparent,
                  ),
                  onTap: () => {
                    widget.modalSetState(() {
                      recurrenceType = RecurrenceType.None;
                    }),
                    HapticFeedback.selectionClick(),
                    Navigator.of(context, rootNavigator: true).pop("Discard")
                  },
                )
              ],
            ),
            PageDivider(
              leftPadding: 0.0,
              rightPadding: 0.0,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Daily',
                    style: popUpMenuText,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    color: Colors.transparent,
                  ),
                  onTap: () => {
                    widget.modalSetState(() {
                      recurrenceType = RecurrenceType.Daily;
                    }),
                    HapticFeedback.selectionClick(),
                    Navigator.of(context, rootNavigator: true).pop("Discard")
                  },
                )
              ],
            ),
            PageDivider(
              leftPadding: 0.0,
              rightPadding: 0.0,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Weekly',
                    style: popUpMenuText,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    color: Colors.transparent,
                  ),
                  onTap: () => {
                    widget.modalSetState(() {
                      recurrenceType = RecurrenceType.Weekly;
                    }),
                    HapticFeedback.selectionClick(),
                    Navigator.of(context, rootNavigator: true).pop("Discard")
                  },
                )
              ],
            ),
            PageDivider(
              leftPadding: 0.0,
              rightPadding: 0.0,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Bi-Weekly',
                    style: popUpMenuText,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    color: Colors.transparent,
                  ),
                  onTap: () => {
                    widget.modalSetState(() {
                      recurrenceType = RecurrenceType.BiWeekly;
                    }),
                    HapticFeedback.selectionClick(),
                    Navigator.of(context, rootNavigator: true).pop("Discard")
                  },
                )
              ],
            ),
            PageDivider(
              leftPadding: 0.0,
              rightPadding: 0.0,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Monthly',
                    style: popUpMenuText,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    color: Colors.transparent,
                  ),
                  onTap: () => {
                    widget.modalSetState(() {
                      recurrenceType = RecurrenceType.Monthly;
                    }),
                    HapticFeedback.selectionClick(),
                    Navigator.of(context, rootNavigator: true).pop("Discard")
                  },
                )
              ],
            ),
            PageDivider(
              leftPadding: 0.0,
              rightPadding: 0.0,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    'Yearly',
                    style: popUpMenuText,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 40,
                    width: double.maxFinite,
                    color: Colors.transparent,
                  ),
                  onTap: () => {
                    widget.modalSetState(() {
                      recurrenceType = RecurrenceType.Yearly;
                    }),
                    HapticFeedback.selectionClick(),
                    Navigator.of(context, rootNavigator: true).pop("Discard")
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
