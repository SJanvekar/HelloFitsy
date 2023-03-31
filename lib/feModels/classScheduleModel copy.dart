import 'dart:ffi';

enum ClassType { solo, group, virtual }

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
  String className;
  String classDescription;
  String classWhatToExpect;
  String classUserRequirements;
  String classImage;
  ClassType classType;
  String classLocation;
  double classRating;
  int classReview;
  double classPrice;
  String classTrainer;
  String trainerFirstName;
  String trainerUsername;
  bool classLiked;
  List<Schedule> classTimes;
  String trainerImageUrl;
  late List<String> classCategories;

  Class({
    required this.className,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classUserRequirements,
    required this.classImage,
    required this.classType,
    required this.classLocation,
    required this.classRating,
    required this.classReview,
    required this.classPrice,
    required this.classLiked,
    required this.classTimes,

    //Trainer Info
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.trainerFirstName,
    required this.trainerUsername,
  });
}

List<Class> classList = [];
