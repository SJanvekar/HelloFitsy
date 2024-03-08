enum ClassType { Solo, Group, Virtual }

class ClassHistory {
  String classHistoryID;
  String userName;
  String classID;

  ClassHistory({
    required this.classHistoryID,
    required this.userName,
    required this.classID,
  });

  //JSON parsers are required to parse arrays of JSON
  ClassHistory.fromJson(Map<String, dynamic> json)
      : classHistoryID = json['_id'],
        userName = json['Username'],
        classID = json['ClassID'];

  Map<String, dynamic> toJson() => {
        '_id': classHistoryID,
        'Username': userName,
        'ClassID': classID,
      };
}
