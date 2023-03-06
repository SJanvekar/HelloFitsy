import 'dart:ffi';
import 'dart:io';

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
  String classTrainerFirstName;
  String classTrainerUsername;
  bool classLiked;
  List<Schedule> classTimes;
  String trainerImageUrl;
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
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.classTrainerFirstName,
    required this.classTrainerUsername,
  });
}

List<Class> classList = [];
