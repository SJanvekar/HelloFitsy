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
  double classPrice;
  String classDescription;
  String classWhatToExpect;
  String classUserRequirements;
  ClassType classType;
  String classLocationName;
  double classLatitude;
  double classLongitude;
  String classTrainer;
  String? purchasedUser;

  ClassSchedule({
    required this.startDate,
    required this.endDate,
    required this.recurrence,
    required this.classImageUrl,
    required this.className,
    required this.classPrice,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classUserRequirements,
    required this.classType,
    required this.classLocationName,
    required this.classLatitude,
    required this.classLongitude,
    required this.classTrainer,
  });
}
