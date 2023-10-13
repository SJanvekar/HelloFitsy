// ignore: constant_identifier_names
enum RecurrenceType { None, Daily, Weekly, BiWeekly, Monthly, Yearly }

class Schedule {
  String scheduleID;
  DateTime startDate;
  DateTime endDate;
  RecurrenceType recurrence;
  String? scheduleReference;
  late bool isSelected = false;

  Schedule(
      {required this.scheduleID,
      required this.startDate,
      required this.endDate,
      required this.recurrence});

  //below two functions for '==' and hashcode are necessary to avoid conflicts
  //when using the Schedule object in a map where Schedule is the key
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Schedule &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          recurrence == other.recurrence;

  @override
  int get hashCode =>
      startDate.hashCode ^ endDate.hashCode ^ recurrence.hashCode;

  Schedule.fromJson(Map<String, dynamic> json)
      : scheduleID = json['_id'],
        startDate = DateTime.parse(json['StartDate']).toLocal(),
        endDate = DateTime.parse(json['EndDate']).toLocal(),
        recurrence = stringToRecurrenceType(
            json['Recurrence'] == null ? "None" : json['Recurrence'][0]),
        scheduleReference = json['ScheduleReference'] ?? '';

  Map<String, dynamic> toJson() => {
        '_id': scheduleID,
        'StartDate': startDate,
        'EndDate': endDate,
        'Recurrence': recurrence.toString(),
        'ScheduleReference': scheduleReference ?? ''
      };
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
