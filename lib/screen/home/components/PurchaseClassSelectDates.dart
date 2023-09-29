import 'dart:collection';

import 'package:balance/Requests/ClassRequests.dart';
import 'package:balance/Requests/StripeRequests.dart';
import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../sharedWidgets/loginFooterButton.dart';
import '../../../sharedWidgets/pageDivider.dart';

class PurchaseClassSelectDates extends StatefulWidget {
  PurchaseClassSelectDates(
      {Key? key,
      required this.classItem,
      required this.userInstance,
      required this.trainerStripeAccountID})
      : super(key: key);

  User userInstance;
  Class classItem;
  String trainerStripeAccountID;

  @override
  State<PurchaseClassSelectDates> createState() =>
      _PurchaseClassSelectDatesState();
}

//Variables
//Schedule Vars
List<Class> currentClass = [];
List<String> trainerIDList = [];
Map<Schedule, Class> availableTimesMap = {};

//Stripe Vars
var paymentIntent;
late String client_secret;
//Temporarily no fitsy commission
var fitsyFee = 0.00;

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _PurchaseClassSelectDatesState extends State<PurchaseClassSelectDates> {
  void initState() {
    super.initState();
    _selectedDays.add(_focusedDay);
    //Clear all lists and maps
    currentClass.clear();
    trainerIDList.add(widget.classItem.classTrainerID);
    getClass(trainerIDList);
  }

//Schedule Functions ------------------------------------------------------------

  //Get Classes for the trainer
  void getClass(List<String> trainerID) async {
    ClassRequests().getClass(trainerID).then((val) async {
      if (val.data['success']) {
        print('successful get class feed');
        (val.data['classArray'] as List<dynamic>).forEach((element) {
          Class classInstance = Class.fromJson(element);
          if (classInstance.classID == widget.classItem.classID) {
            currentClass.add(classInstance);
          }
        });
      } else {
        print('error get class feed: ${val.data['msg']}');
      }
      determineDaySchedule(currentClass, _selectedDays);
      setState(() {});
    });
  }

  //Determine today's schedule
  void determineDaySchedule(
      List<Class> currentClass, Set<DateTime> selectedDays) {
    availableTimesMap.clear();

    for (var selectedDay in selectedDays) {
      for (var classItem in currentClass) {
        shouldScheduleClass(classItem, selectedDay);
      }
    }
  }

  void shouldScheduleClass(Class classItem, DateTime selectedDay) {
    for (Schedule classTime in classItem.classTimes) {
      final DateTime startDate = classTime.startDate;
      final RecurrenceType recurrence = classTime.recurrence;

      //Find the difference between the currently selected date and the start date
      int daysBetween(DateTime from, DateTime to) {
        from = DateTime(from.year, from.month, from.day);
        to = DateTime(to.year, to.month, to.day);
        return (to.difference(from).inHours / 24).round();
      }

      final int dateDifference = daysBetween(startDate, selectedDay);

      //First check if today is the original start date
      if (startDate.day == selectedDay.day &&
          startDate.month == selectedDay.month &&
          startDate.year == selectedDay.year) {
        availableTimesMap[classTime] = classItem;
        continue;
      }

      //Second check the recurrance if it is anything other than none (None is handled with the above check)
      if (recurrence == RecurrenceType.Daily &&
          dateDifference % 1 == 0 &&
          dateDifference != 0) {
        availableTimesMap[classTime] = classItem;
        continue;
      } else if (recurrence == RecurrenceType.Weekly &&
          dateDifference % 7 == 0 &&
          dateDifference != 0) {
        availableTimesMap[classTime] = classItem;
        continue;
      } else if (recurrence == RecurrenceType.BiWeekly &&
          dateDifference % 14 == 0 &&
          dateDifference != 0) {
        availableTimesMap[classTime] = classItem;
        continue;
      } else if (recurrence == RecurrenceType.Monthly &&
          startDate.month != selectedDay.month &&
          startDate.day == selectedDay.day) {
        availableTimesMap[classTime] = classItem;
        continue;
      } else if (recurrence == RecurrenceType.Yearly &&
          startDate.year != selectedDay.year &&
          startDate.month == selectedDay.month &&
          startDate.day == selectedDay.day) {
        availableTimesMap[classTime] = classItem;
        continue;
      }
    }
  }

//Stripe Functions ------------------------------------------------------------

  Future<void> createPaymentIntent() async {
    try {
      print(widget.classItem.classPrice);
      final response = await StripeRequests().newPaymentIntent(
          widget.userInstance.stripeCustomerID,
          10,
          fitsyFee,
          widget.trainerStripeAccountID);

      if (response.data['success']) {
        // Store customerID & paymentIntent object
        final customerID = response.data['customerID'];
        paymentIntent = response.data['paymentIntent'];
        client_secret = response.data['client_secret'];

        // Check if customerID was null and needs to be updated
        if (widget.userInstance.stripeCustomerID == null) {
          // Update the AccountID on the user level in the database
          await UserRequests().updateUserStripeCustomerID(
            customerID,
            widget.userInstance.userName,
          );

          // Update the customer ID in the user instance
          widget.userInstance.stripeCustomerID = customerID;
        }
      }
    } catch (error) {
      print('Error creating payment intent: $error');
      throw Exception(error);
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        // Clear paymentIntent variable after successful payment
        paymentIntent = null;
      });
    } on StripeException catch (e) {
      print('Stripe Error: $e');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> makePayment() async {
    try {
      // Create Payment Intent
      await createPaymentIntent();

      await Future.delayed(Duration(milliseconds: 250), () {
        // STEP 2: Initialize Payment Sheet
        return Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: client_secret,
            style: ThemeMode.light,
            merchantDisplayName: 'Fitsy',
          ),
        );
      });

      // STEP 3: Display Payment Sheet
      await displayPaymentSheet();
    } catch (err) {
      print('Error making payment: $err');
      throw Exception(err);
    }
  }

//variables
  DateTime _focusedDay = DateTime.now();
  var _formattedDate;
  var _focusedDateStartTimes = [];

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
            color: strawberry,
          ),
          child: Text(
            date.day.toString(),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15.0,
                color: snow,
                fontFamily: 'SFDisplay'),
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
      HapticFeedback.selectionClick();
      _focusedDay = focusedDay;
      _formattedDate =
          Jiffy.parseFromDateTime(_focusedDay).format(pattern: "MMMM do");
      _selectedDays.clear();
      _selectedDays.add(selectedDay);
      determineDaySchedule(currentClass, _selectedDays);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setPurchaseClassState) {
        return Material(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: BoxDecoration(
              color: snow,
              borderRadius: BorderRadius.circular(20),
            ),
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
                        bottom: 25,
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
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.classItem.classImageUrl,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.classItem.className,
                            style: sectionTitles,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: PageDivider(leftPadding: 0.0, rightPadding: 0.0),
                  ),
                  TableCalendar(
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Available Times',
                      style: sectionTitlesH2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        MultiSliver(
                          children: [
                            SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                                childAspectRatio: 2,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final classTime =
                                      availableTimesMap.keys.elementAt(index);
                                  final classItem =
                                      availableTimesMap[classTime]!;
                                  TextStyle startTimeStyle = classStartTime;
                                  TextStyle endTimeStyle = classEndTime;
                                  Color timeContainerColor = bone;
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter selectTimeState) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 5.0,
                                          right: 5.0,
                                        ),
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: classTime.isSelected
                                                  ? strawberry
                                                  : bone,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  Jiffy.parse(classTime
                                                          .startDate
                                                          .toString())
                                                      .format(
                                                    pattern: "h:mm a",
                                                  ),
                                                  style: classTime.isSelected
                                                      ? classStartTimeSelected
                                                      : classStartTime,
                                                ),
                                                Text(
                                                  Jiffy.parse(classTime.endDate
                                                          .toString())
                                                      .format(
                                                    pattern: "h:mm a",
                                                  ),
                                                  style: classTime.isSelected
                                                      ? classEndTimeSelected
                                                      : classEndTime,
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            HapticFeedback.selectionClick();
                                            selectTimeState(() {
                                              print(classTime.startDate);
                                              print(classTime.endDate);
                                              classTime.isSelected =
                                                  !classTime.isSelected;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: availableTimesMap.length,
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.classItem.classPrice < 1)
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: bone, width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 46,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: GestureDetector(
                            child: FooterButton(
                              buttonColor: strawberry,
                              buttonText: 'Book Class',
                              textColor: snow,
                            ),
                            onTap: () => {
                              //TODO: Add SCHEDULE ADD FUNCTION HERE
                              Navigator.of(context).pop()
                            },
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: bone, width: 1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 14,
                          bottom: 46,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: GestureDetector(
                            child: FooterButton(
                              buttonColor: strawberry,
                              buttonText: 'Purchase Class',
                              textColor: snow,
                            ),
                            onTap: () => {
                              makePayment(),
                              // Navigator.of(context).pop()
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
