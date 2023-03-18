import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

enum ClassType { Solo, Group, Virtual }

class Schedule {
  Set<DateTime> dates;
  DateTime startTime;
  DateTime endTime;

  Schedule({
    required this.dates,
    required this.startTime,
    required this.endTime,
  });
}

class Class {
  String classImageUrl;
  String className;
  double classPrice;
  String classDescription;
  String classWhatToExpect;
  String classUserRequirements;
  ClassType classType;
  String classLocation;
  double classRating;
  int classReview;
  String classTrainer;
  late String classTrainerFirstName;
  late String classTrainerUsername;
  bool classLiked;
  late List<Schedule> classTimes;
  late String trainerImageUrl;
  late List<String> classCategories;
  File? profileImageTempHolder;

  Class({
    required this.classImageUrl,
    required this.className,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classUserRequirements,
    required this.classType,
    required this.classLocation,
    required this.classRating,
    required this.classReview,
    required this.classPrice,
    required this.classLiked,
    required this.classTimes,

    //Trainer Info
    //WHAT THE FUCK IS THIS
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.classTrainerFirstName,
    required this.classTrainerUsername,
  });

  Class.fromJson(Map<String, dynamic> json)
      : className = json['ClassName'],
        classImageUrl = json['ClassImageUrl'],
        classDescription = json['ClassDescription'],
        classWhatToExpect = json['ClassWhatToExpect'],
        classUserRequirements = json['ClassUserRequirements'],
        classType = stringToClassType(json['ClassType'][0]),
        classLocation = json['ClassLocation'],
        classRating = json['ClassRating'].toDouble(),
        classReview = json['ClassReview'],
        classPrice = json['ClassPrice'].toDouble(),
        classTrainer = json['ClassTrainer'],
        classLiked = json['ClassLiked'];

  Map<String, dynamic> toJson() => {
        'ClassName': className,
        'ClassImageUrl': classImageUrl,
        'ClassDescription': classDescription,
        'ClassWhatToExpect': classWhatToExpect,
        'ClassUserRequirements': classUserRequirements,
        'ClassType': classType.toString(),
        'ClassLocation': classLocation,
        'ClassRating': classRating,
        'ClassReview': classReview,
        'ClassPrice': classPrice,
        'ClassTrainer': classTrainer,
        'ClassLiked': classLiked
      };
}

ClassType stringToClassType(String string) {
  switch (string) {
    case "Solo":
      return ClassType.Solo;
    case "Group":
      return ClassType.Group;
    case "Virtual":
      return ClassType.Virtual;
    default:
      throw Exception('String to ClassType cast failed');
  }
}

List<Class> classList = [];
