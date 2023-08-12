// ignore_for_file: prefer_const_constructors, avoid_print, unused_import, file_names
import 'dart:ffi';
import 'dart:collection';
import 'package:balance/Authentication/authService.dart';
import 'package:balance/constants.dart';
import 'package:balance/example.dart';
import 'package:balance/screen/createClass/createClassStep6UploadClassPhoto.dart';
import 'package:balance/screen/createClass/CreateClassTimeList.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/home/components/ClassCardOpen.dart';
import 'package:balance/screen/login/login.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/screen/login/loginSharedWidgets/userTextInput.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/screen/profile/components/scheduledClassItem.dart';
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

String recurranceType = 'None';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendar();
}

//Global Variables
DateTime startTime = DateTime.now();
DateTime endTime = DateTime.now().add(Duration(hours: 1));
bool isClassSelected = false;
String selectedClassName = '';
String selectedClassImageUrl = '';
List<Class> scheduledClassesList = classList;
List<Class> allClasses = classList;

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
  //variables
  DateTime _focusedDay = DateTime.now();
  var _formattedDate;
  var _focusedDateStartTimes = [];

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void initState() {
    super.initState();
    _selectedDays.add(_focusedDay);
  }

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
          fontSize: 22.0,
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
      _focusedDay = focusedDay;
      _formattedDate =
          Jiffy.parseFromDateTime(_focusedDay).format(pattern: "MMMM do");
      _selectedDays.clear();
      _selectedDays.add(selectedDay);
      // // Update values in a Set
      // if (_selectedDays.contains(selectedDay)) {
      //   _selectedDays.remove(selectedDay);
      // } else {
      //   _selectedDays.add(selectedDay);
      // }
    });

    void _onRecurranceTypeChange() {
      switch (recurranceType) {
        case 'None':
          return;

        case 'Daily':
      }
    }
  }

  void displayClassAndTimePicker() {
    isClassSelected = false;

    //Start Time Format
    String returnedTime = '';

    void formatTimes(DateTime dateToFormat) {
      String formattedDate = dateToFormat.toString();
      Jiffy.parse(formattedDate).format(pattern: "h:mm a");
      returnedTime = Jiffy.parse(formattedDate).format(pattern: "h:mm a");
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
              formatTimes(startTime);
              String startTimeFormatted = returnedTime;
              formatTimes(endTime);
              String endTimeFormatted = returnedTime;

              return Material(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.60,
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
                                            setModalSheetPage2State);
                                      },
                                    )
                                  else
                                    GestureDetector(
                                      child: selectClassListItem(
                                          selectedClassImageUrl,
                                          selectedClassName),
                                      onTap: () {
                                        displayClassPicker(
                                            setModalSheetPage2State);
                                      },
                                    ),
                                  SizedBox(height: 25),
                                  Column(
                                    children: [
                                      GestureDetector(
                                          child: Container(
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
                                                true, setModalSheetPage2State);
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
                                                false, setModalSheetPage2State);
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
                                                          recurranceType,
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
                                  GestureDetector(
                                    child: FooterButton(
                                        buttonColor: ocean,
                                        textColor: snow,
                                        buttonText: 'Save'),
                                    onTap: () => {Navigator.of(context).pop()},
                                  ),
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
  void displayTimePicker(bool isStartDateLabel, StateSetter modalsetState) {
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
            height: MediaQuery.of(context).copyWith().size.height * 0.57,
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
                    "Select a time",
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
                // Container(
                //   child: Divider(
                //     thickness: 0.33,
                //     color: shark,
                //     indent: 10,
                //     endIndent: 10,
                //   ),
                // ),
                Container(
                  height: MediaQuery.of(context).copyWith().size.height * 0.3,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (value) {
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
                    },
                    initialDateTime: initialTime,
                    minimumYear: 2019,
                    maximumYear: 2050,
                  ),
                ),
                SizedBox(height: 50.0),
                GestureDetector(
                  child: FooterButton(
                      buttonColor: bone,
                      textColor: jetBlack,
                      buttonText: 'Done'),
                  onTap: () {
                    Navigator.of(context).pop();
                    modalsetState(() {
                      startTime = startTime;
                      endTime = endTime;
                    });
                  },
                )
              ],
            ),
          );
        });
  }

  //Class Picker Modal Sheet
  void displayClassPicker(StateSetter modalsetState) {
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
                        final allClassesList = allClasses[index];
                        return GestureDetector(
                          child: selectClassListItem(
                              allClassesList.classImageUrl,
                              allClassesList.className),
                          onTap: () {
                            modalsetState(() {
                              isClassSelected = true;
                              selectedClassName = allClassesList.className;
                              selectedClassImageUrl =
                                  allClassesList.classImageUrl;
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
    void doNothing(BuildContext context) {}
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
                    Navigator.of(context).pop();
                  },
                  child: Text("Back", style: logInPageNavigationButtons),
                ),
              ),
            ],
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
                  recurranceType = 'None';
                  startTime = DateTime.now();
                  endTime = DateTime.now().add(Duration(hours: 1));
                  displayClassAndTimePicker();
                },
              ),
            )
          ]),

      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10),
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
              SizedBox(
                height: 250,
                child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top: 20, left: 26.0, right: 26.0),
                    itemCount: scheduledClassesList.length,
                    itemBuilder: (context, index) {
                      final scheduledClass = scheduledClassesList[index];
                      return GestureDetector(
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: ScrollMotion(), children: [
                            SlidableAction(
                              // An action can be bigger than the others.
                              flex: 2,
                              onPressed: doNothing,
                              backgroundColor: bone,
                              foregroundColor: jetBlack,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              flex: 2,
                              onPressed: doNothing,
                              backgroundColor: strawberry,
                              foregroundColor: snow,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                            ),
                          ]),
                          child: ScheduledClassTile(
                            classImageUrl: scheduledClass.classImageUrl,
                            classTitle: scheduledClass.className,
                            classTrainer: scheduledClass.trainerFirstName,
                            classTrainerImageUrl:
                                scheduledClass.trainerImageUrl,
                            classDescription: scheduledClass.classDescription,
                            classLocationName: scheduledClass.classLocationName,
                            classPrice: scheduledClass.classPrice,
                            classRating: scheduledClass.classOverallRating,
                            classReviews: scheduledClass.classReviewsAmount,
                            classTrainerFirstName:
                                scheduledClass.trainerFirstName,
                            classTrainerLastName:
                                scheduledClass.trainerLastName,
                            classType: scheduledClass.classType,
                            classWhatToExpect: scheduledClass.classWhatToExpect,
                            classWhatYouWillNeed:
                                scheduledClass.classUserRequirements,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )
        ],
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
              displayTimePicker(true, setState);
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
              displayTimePicker(false, setState);
            },
          ),
        ],
      ),
    );
  }
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
    print('hi there');

    //Call bolding/selection trait function here (Bold selected option)
  }

  @override
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
                      recurranceType = 'None';
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
                      recurranceType = 'Daily';
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
                      recurranceType = 'Weekly';
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
                      recurranceType = 'Bi-Weekly';
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
                      recurranceType = 'Monthly';
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
                      recurranceType = 'Yearly';
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
