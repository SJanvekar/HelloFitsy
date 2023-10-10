// ignore: constant_identifier_names
enum RecurrenceType { None, Daily, Weekly, BiWeekly, Monthly, Yearly }

// ignore: constant_identifier_names
enum ClassType { Solo, Group, Virtual }

class ClassSchedule {
  String classID;
  String userID;

  ClassSchedule({required this.classID, required this.userID});
}
