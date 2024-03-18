import 'dart:convert';

enum ClassType { Solo, Group, Virtual }

class ClassHistory {
  String classHistoryID;
  String userID;
  String classID;
  DateTime? dateTaken;
  List<DateTime>? takenStartTimes;
  bool? isMissed;
  bool? isCancelled;

  ClassHistory({
    required this.classHistoryID,
    required this.userID,
    required this.classID,
  });

  //JSON parsers are required to parse arrays of JSON
  ClassHistory.fromJson(Map<String, dynamic> json)
      : classHistoryID = json['_id'],
        userID = json['UserID'],
        classID = json['ClassID'],
        dateTaken = DateTime.parse(json['DateTaken']).toLocal(),
        takenStartTimes = parseDateTimeList(json['TakenStartTimes']),
        isMissed = json['IsMissed'],
        isCancelled = json['IsCancelled'];

  Map<String, dynamic> toJson() => {
        '_id': classHistoryID,
        'Username': userID,
        'ClassID': classID,
        'DateTaken': dateTaken,
        'TakenStartTimes':
            json.encode(takenStartTimes?.map((element) => element).toList()),
        'IsMissed': isMissed,
        'IsCancelled': isCancelled,
      };

  static List<DateTime>? parseDateTimeList(dynamic dateTimeString) {
    if (dateTimeString == null) {
      return [];
    }
    List<DateTime> allDateTimes = [];
    (dateTimeString as List<dynamic>).forEach((element) {
      allDateTimes.add(DateTime.parse(element).toLocal());
    });
    return allDateTimes;
  }
}
