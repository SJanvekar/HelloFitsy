import 'dart:collection';
import 'dart:convert';
import 'package:balance/screen/home/components/homeClassItem.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:balance/constants.dart';
import 'package:balance/payments/paymentSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../sharedWidgets/loginFooterButton.dart';
import '../../../sharedWidgets/pageDivider.dart';

class PurchaseClassSelectDates extends StatefulWidget {
  PurchaseClassSelectDates({
    Key? key,
    required this.classImageUrl,
    required this.className,
    required this.classPrice,
  }) : super(key: key);

  String classImageUrl;
  String className;
  double classPrice;

  @override
  State<PurchaseClassSelectDates> createState() =>
      _PurchaseClassSelectDatesState();
}

//Initialize Payment Intent
var paymentIntent;

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

//---------------- Functions for Payment ----------------------

//Initalize the payment intent
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//Make Payment Function
  Future<void> makePayment(paymentAmount, paymentCurrency) async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent(paymentAmount, paymentCurrency);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Fitsy'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        //Clear paymentIntent variable after successful payment
        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
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
                                image: NetworkImage(widget.classImageUrl),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            widget.className,
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
                              onTap: () {
                                //Stripe caculates amounts in cents, i.e. a 1 dollar is passed into the Stripe API as 10 (cents).
                                var classPriceTotal = widget.classPrice * 100;

                                //Call Make Payment (round() is used to make sure there are no decimals in the passed in amount, this will not be accepted by stripe)
                                makePayment(
                                    classPriceTotal.round().toString(), 'CAD');
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
