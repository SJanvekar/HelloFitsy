// ignore: constant_identifier_names
enum RecurrenceType { None, Daily, Weekly, BiWeekly, Monthly, Yearly }

//Base class with members shared by all schedules
class BaseSchedule {
  String scheduleID;
  DateTime startDate;
  DateTime endDate;
  late bool isSelected = false;

  BaseSchedule({
    required this.scheduleID,
    required this.startDate,
    required this.endDate,
  });

  /* Below functions for '==' and hashcode are necessary to avoid conflicts
  when using the Schedule object in a map where Schedule is the key */
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Schedule &&
          scheduleID == other.scheduleID &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode =>
      scheduleID.hashCode ^ startDate.hashCode ^ endDate.hashCode;

  BaseSchedule.fromJson(Map<String, dynamic> json)
      : scheduleID = json['_id'],
        startDate = DateTime.parse(json['StartDate']).toLocal(),
        endDate = DateTime.parse(json['EndDate']).toLocal();

  Map<String, dynamic> toJson() =>
      {'_id': scheduleID, 'StartDate': startDate, 'EndDate': endDate};
}

//Default Schedule
class Schedule extends BaseSchedule {
  RecurrenceType recurrence;
  late bool isBooked = true;

  Schedule({
    required String scheduleID,
    required DateTime startDate,
    required DateTime endDate,
    required this.recurrence,
  }) : super(scheduleID: scheduleID, startDate: startDate, endDate: endDate);

  Schedule.fromJson(Map<String, dynamic> json)
      : recurrence = stringToRecurrenceType(
            json['Recurrence'] == null ? "None" : json['Recurrence'][0]),
        super(
            scheduleID: json['_id'],
            startDate: DateTime.parse(json['StartDate']).toLocal(),
            endDate: DateTime.parse(json['EndDate']).toLocal());

  Map<String, dynamic> toJson() {
    final parentJson = super.toJson();
    return {
      ...parentJson,
      'Recurrence': recurrence.toString(),
    };
  }

  static List<Schedule> parseClassTimes(dynamic dateTimeString) {
    if (dateTimeString == null) {
      return [];
    }
    List<Schedule> allSchedules = [];
    (dateTimeString as List<dynamic>).forEach((element) {
      allSchedules.add(Schedule.fromJson(element));
    });
    return allSchedules;
  }
}

class UpdatedSchedule extends BaseSchedule {
  String? scheduleReference;
  late bool isBooked = true;

  UpdatedSchedule({
    required String scheduleID,
    required DateTime startDate,
    required DateTime endDate,
  }) : super(scheduleID: scheduleID, startDate: startDate, endDate: endDate);

  //below two functions for '==' and hashcode are necessary to avoid conflicts
  //when using the Schedule object in a map where Schedule is the key
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Schedule &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode => startDate.hashCode ^ endDate.hashCode;

  UpdatedSchedule.fromJson(Map<String, dynamic> json)
      : super(
          scheduleID: json['_id'],
          startDate: DateTime.parse(json['StartDate']).toLocal(),
          endDate: DateTime.parse(json['EndDate']).toLocal(),
        ) {
    scheduleReference = json['ScheduleReference'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final parentJson = super.toJson();
    return {
      ...parentJson,
      'ScheduleReference': scheduleReference ?? '',
    };
  }

  static List<UpdatedSchedule> parseClassTimes(dynamic dateTimeString) {
    if (dateTimeString == null) {
      return [];
    }
    List<UpdatedSchedule> allSchedules = [];
    (dateTimeString as List<dynamic>).forEach((element) {
      allSchedules.add(UpdatedSchedule.fromJson(element));
    });
    return allSchedules;
  }
}

class CancelledSchedule extends BaseSchedule {
  String? scheduleReference;
  late bool isCancelled = false;

  CancelledSchedule({
    required String scheduleID,
    required DateTime startDate,
    required DateTime endDate,
  }) : super(scheduleID: scheduleID, startDate: startDate, endDate: endDate);

  //below two functions for '==' and hashcode are necessary to avoid conflicts
  //when using the Schedule object in a map where Schedule is the key
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Schedule &&
          startDate == other.startDate &&
          endDate == other.endDate;

  @override
  int get hashCode => startDate.hashCode ^ endDate.hashCode;

  CancelledSchedule.fromJson(Map<String, dynamic> json)
      : super(
          scheduleID: json['_id'],
          startDate: DateTime.parse(json['StartDate']).toLocal(),
          endDate: DateTime.parse(json['EndDate']).toLocal(),
        ) {
    scheduleReference = json['ScheduleReference'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final parentJson = super.toJson();
    return {
      ...parentJson,
      'ScheduleReference': scheduleReference ?? '',
    };
  }

  static List<CancelledSchedule> parseClassTimes(dynamic dateTimeString) {
    if (dateTimeString == null) {
      return [];
    }
    List<CancelledSchedule> allSchedules = [];
    (dateTimeString as List<dynamic>).forEach((element) {
      allSchedules.add(CancelledSchedule.fromJson(element));
    });
    return allSchedules;
  }
}

//Semi-hardcoded casting from String to RecurrenceType,
//not optimal but the best I can think of right now
RecurrenceType stringToRecurrenceType(String recurrenceString) {
  switch (recurrenceString) {
    case "None":
      return RecurrenceType.None;
    case "Daily":
      return RecurrenceType.Daily;
    case "Weekly":
      return RecurrenceType.Weekly;
    case "BiWeekly":
      return RecurrenceType.BiWeekly;
    case "Monthly":
      return RecurrenceType.Monthly;
    case "Yearly":
      return RecurrenceType.Yearly;
    default:
      throw Exception('String to RecurrenceType cast failed');
  }
}
