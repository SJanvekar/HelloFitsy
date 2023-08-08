// ignore: constant_identifier_names
enum RecurrenceType { None, Daily, Weekly, BiWeekly, Monthly, Yearly }

// ignore: constant_identifier_names
enum ClassType { Solo, Group, Virtual }

class ClassSchedule {
  DateTime startDate;
  DateTime endDate;
  RecurrenceType recurrence;
  String classImageUrl;
  String className;
  String classTrainerUsername;
  ClassType classType;
  String? purchasedUser;

  ClassSchedule(
      {required this.startDate,
      required this.endDate,
      required this.recurrence,
      required this.classImageUrl,
      required this.className,
      required this.classTrainerUsername,
      required this.classType});
}
