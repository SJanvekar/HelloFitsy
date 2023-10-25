// ignore: constant_identifier_names
import 'package:balance/feModels/ScheduleModel.dart';

enum RecurrenceType { None, Daily, Weekly, BiWeekly, Monthly, Yearly }

// ignore: constant_identifier_names
enum ClassType { Solo, Group, Virtual }

class ClassSchedule {
  String classID;
  String userID;

  late List<Schedule> classTimes;
  List<UpdatedSchedule>? updatedClassTimes;
  List<CancelledSchedule>? cancelledClassTimes;

  DateTime dateBooked;
  double pricePaid;
  bool? isMissed;
  bool? isCancelled;
  String? cancellationReason;

  ClassSchedule(
      {required this.classID,
      required this.userID,
      required this.dateBooked,
      required this.pricePaid});
}
