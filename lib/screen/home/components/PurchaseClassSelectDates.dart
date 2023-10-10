import 'dart:collection';

import 'package:balance/Requests/StripeRequests.dart';
import 'package:balance/Requests/UserRequests.dart';
import 'package:balance/constants.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/profile/components/createClassSchedule.dart';
import 'package:flutter/cupertino.dart';
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

//Test List of Dates/Times for purchasing a class (This is a custom class, will definately need cleaning up)
class classTimes {
  late DateTime startTime;
  late DateTime endTime;
  bool isSelected = false;

  classTimes(
      {required this.startTime,
      required this.endTime,
      required this.isSelected});
}

List<classTimes> availableTimesTemp = [
  classTimes(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(Duration(hours: 2)),
      isSelected: false),
  classTimes(
      startTime: DateTime.now().add(Duration(hours: 4)),
      endTime: DateTime.now().add(Duration(hours: 6)),
      isSelected: false),
  classTimes(
      startTime: DateTime.now().add(Duration(hours: 8)),
      endTime: DateTime.now().add(Duration(hours: 10)),
      isSelected: false),
];

var paymentIntent;
late String client_secret;

//Temporarily no fitsy commission
var fitsyFee = 0;

//Initialize the list for times for this class
List<classTimes> availableTimes = availableTimesTemp;

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _PurchaseClassSelectDatesState extends State<PurchaseClassSelectDates> {
  void initState() {
    super.initState();
    _selectedDays.add(_focusedDay);
  }

//Stripe Functions ------------------------------------------------------------

  Future<void> createPaymentIntent() async {
    try {
      final response = await StripeRequests().newPaymentIntent(
          widget.userInstance.stripeCustomerID,
          100,
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
                                    widget.classItem.classImageUrl),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.classItem.className,
                            style: sectionTitles,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: PageDivider(leftPadding: 0.0, rightPadding: 0.0),
                    ),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          MultiSliver(children: [
                            Column(
                              children: [
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
                              ],
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
                                  final classTime = availableTimes[index];
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
                                                    BorderRadius.circular(20)),
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    Jiffy.parse(classTime
                                                            .startTime
                                                            .toString())
                                                        .format(
                                                            pattern: "h:mm a"),
                                                    style: classTime.isSelected
                                                        ? classStartTimeSelected
                                                        : classStartTime,
                                                  ),
                                                  Text(
                                                    Jiffy.parse(classTime
                                                            .endTime
                                                            .toString())
                                                        .format(
                                                            pattern: "h:mm a"),
                                                    style: classTime.isSelected
                                                        ? classEndTimeSelected
                                                        : classEndTime,
                                                  ),
                                                ]),
                                          ),
                                          onTap: () {
                                            HapticFeedback.selectionClick();
                                            selectTimeState(() {
                                              print(classTime.startTime);
                                              print(classTime.endTime);
                                              classTime.isSelected =
                                                  !classTime.isSelected;
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: availableTimes.length,
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Spacer(),
                          ])
                        ],
                      ),
                    ),
                    if (widget.classItem.classPrice < 1)
                      Container(
                          height: 110,
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: bone, width: 1),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 46,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
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
                          ))
                    else
                      Container(
                          height: 110,
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: bone, width: 1),
                          )),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 14,
                              bottom: 46,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 0.0),
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
                          )),
                  ],
                ),
              )),
        );
      },
    );
  }
}
