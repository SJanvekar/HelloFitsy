import 'dart:ffi';

class DateSchedule {
  DateTime date;
  DateTime startTime;
  DateTime endTime;

  DateSchedule({
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}

List<DateSchedule> classList = [];
