import 'dart:io';
import 'dart:convert';

import 'package:balance/feModels/ScheduleModel.dart';

// ignore: constant_identifier_names
enum ClassType { Solo, Group, Virtual }

class Class {
  String classID;
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
  double classOverallRating;
  int classReviewsAmount;
  String classTrainerID;
  late List<Schedule> classTimes;
  late List<UpdatedSchedule> updatedClassTimes;
  late List<CancelledSchedule> cancelledClassTimes;
  late List<String> classCategories;
  File? profileImageTempHolder;
  bool isEditMode = false;

  Class({
    required this.classID,
    required this.classImageUrl,
    required this.className,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classUserRequirements,
    required this.classType,
    required this.classLocationName,
    required this.classLatitude,
    required this.classLongitude,
    required this.classOverallRating,
    required this.classReviewsAmount,

    //Good after this point
    required this.classPrice,
    required this.classTimes,
    required this.updatedClassTimes,
    required this.cancelledClassTimes,
    required this.classCategories,

    //Trainer Info
    required this.classTrainerID,
  });

  //JSON parsers are required to parse arrays of JSON
  Class.fromJson(Map<String, dynamic> json)
      : classID = json['_id'],
        className = json['ClassName'],
        classImageUrl = json['ClassImageUrl'],
        classDescription = json['ClassDescription'],
        classWhatToExpect = json['ClassWhatToExpect'],
        classUserRequirements = json['ClassUserRequirements'],
        classType = stringToClassType(json['ClassType'][0]),
        classLocationName = json['ClassLocationName'],
        classLatitude = json['ClassLatitude'].toDouble(),
        classLongitude = json['ClassLongitude'].toDouble(),
        classOverallRating = json['ClassOverallRating'].toDouble(),
        classReviewsAmount = json['ClassReviewsAmount'],
        classPrice = json['ClassPrice'].toDouble(),
        classTimes = Schedule.parseClassTimes(json['ClassTimes']),
        updatedClassTimes =
            UpdatedSchedule.parseClassTimes(json['UpdatedClassTimes']),
        cancelledClassTimes =
            CancelledSchedule.parseClassTimes(json['CancelledClassTimes']),
        classCategories = List<String>.from(json['Categories']),
        classTrainerID = json['ClassTrainerID'];

  Map<String, dynamic> toJson() => {
        '_id': classID,
        'ClassName': className,
        'ClassImageUrl': classImageUrl,
        'ClassDescription': classDescription,
        'ClassWhatToExpect': classWhatToExpect,
        'ClassUserRequirements': classUserRequirements,
        'ClassType': classType.toString(),
        'ClassLocationName': classLocationName,
        'ClassLatitude': classLatitude,
        'ClassLongitude': classLongitude,
        'ClassRating': classOverallRating,
        'ClassReview': classReviewsAmount,
        'ClassPrice': classPrice,
        //NOTE: have not confirmed if ClassTimes or Categories work for this,
        //because there hasn't been a need to use Class.toJson() yet.
        //If Class.toJson() fails, let me know. -Will
        'ClassTimes':
            json.encode(classTimes.map((element) => element.toJson()).toList()),
        'UpdatedClassTimes': json.encode(
            updatedClassTimes.map((element) => element.toJson()).toList()),
        'CancelledClassTimes': json.encode(
            cancelledClassTimes.map((element) => element.toJson()).toList()),
        'Categories': json.encode(classCategories),
        'ClassTrainerID': classTrainerID
      };
}

//Semi-hardcoded casting from String to ClassType,
//not optimal but the best I can think of right now
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

List<Class> classList = [
  Class(
      classImageUrl:
          'https://www.londonmagicaltours.com/img/Wimbledon-tennis-tours-1.jpg',
      className: 'Wimbledon Championship 2023 - Hosted by Patek Phillipe',
      classDescription:
          "Our mission is to champion opportunities for all. We use the collective strength of the All England Club and The Championships to make a positive difference to people's lives. - Respond in times of need by making a difference to those facing adversity.",
      classWhatToExpect:
          "The Foundation is governed by a board of seven Trustees with a wide range of charitable and business expertise and the day to day operations are managed by the Foundation team.",
      classUserRequirements:
          "There are a number of ways to buy Wimbledon tickets; these include purchasing long term debenture seats, the UK and overseas public ballots, queuing on the day or trying to purchase tickets the day before online.",
      classType: ClassType.Group,
      classPrice: 400,
      classTimes: [],
      classID: '',
      classLocationName: '',
      classLatitude: 0,
      classLongitude: 0,
      classOverallRating: 0,
      classReviewsAmount: 0,
      updatedClassTimes: [],
      cancelledClassTimes: [],
      classCategories: [],
      classTrainerID: ''),
  Class(
      classImageUrl:
          'https://www.londonmagicaltours.com/img/Wimbledon-tennis-tours-1.jpg',
      className: 'Wimbledon Championship 2023 - Hosted by Patek Phillipe',
      classDescription:
          "Our mission is to champion opportunities for all. We use the collective strength of the All England Club and The Championships to make a positive difference to people's lives. - Respond in times of need by making a difference to those facing adversity.",
      classWhatToExpect:
          "The Foundation is governed by a board of seven Trustees with a wide range of charitable and business expertise and the day to day operations are managed by the Foundation team.",
      classUserRequirements:
          "There are a number of ways to buy Wimbledon tickets; these include purchasing long term debenture seats, the UK and overseas public ballots, queuing on the day or trying to purchase tickets the day before online.",
      classType: ClassType.Group,
      classPrice: 400,
      classTimes: [],
      classID: '',
      classLocationName: '',
      classLatitude: 0,
      classLongitude: 0,
      classOverallRating: 0,
      classReviewsAmount: 0,
      updatedClassTimes: [],
      cancelledClassTimes: [],
      classCategories: [],
      classTrainerID: ''),
  Class(
      classImageUrl:
          'https://www.londonmagicaltours.com/img/Wimbledon-tennis-tours-1.jpg',
      className: 'Wimbledon Championship 2023 - Hosted by Patek Phillipe',
      classDescription:
          "Our mission is to champion opportunities for all. We use the collective strength of the All England Club and The Championships to make a positive difference to people's lives. - Respond in times of need by making a difference to those facing adversity.",
      classWhatToExpect:
          "The Foundation is governed by a board of seven Trustees with a wide range of charitable and business expertise and the day to day operations are managed by the Foundation team.",
      classUserRequirements:
          "There are a number of ways to buy Wimbledon tickets; these include purchasing long term debenture seats, the UK and overseas public ballots, queuing on the day or trying to purchase tickets the day before online.",
      classType: ClassType.Group,
      classPrice: 400,
      classTimes: [],
      classID: '',
      classLocationName: '',
      classLatitude: 0,
      classLongitude: 0,
      classOverallRating: 0,
      classReviewsAmount: 0,
      updatedClassTimes: [],
      cancelledClassTimes: [],
      classCategories: [],
      classTrainerID: ''),
];
