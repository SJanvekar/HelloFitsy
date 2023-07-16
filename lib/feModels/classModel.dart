import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

enum ClassType { Solo, Group, Virtual }

class Schedule {
  DateTime startDate;
  DateTime endDate;

  Schedule({
    required this.startDate,
    required this.endDate,
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
  String classLocationName;
  double classLatitude;
  double classLongitude;
  double classRating;
  int classReview;
  String classTrainer;
  String trainerFirstName;
  String trainerLastName;
  bool classLiked;
  late List<Schedule> classTimes;
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
    required this.classLocationName,
    required this.classLatitude,
    required this.classLongitude,
    required this.classRating,

    //What the fuck is class review? I can't rememmber - Salman
    required this.classReview,

    //Good after this point
    required this.classPrice,
    required this.classLiked,

    //May need to rework this based on new workflow
    required this.classTimes,

    //Trainer Info
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.trainerFirstName,
    required this.trainerLastName,
    // required this.trainerUsername,
  });

  //JSON parsers are required to parse arrays of JSON
  Class.fromJson(Map<String, dynamic> json)
      : className = json['ClassName'],
        classImageUrl = json['ClassImageUrl'],
        classDescription = json['ClassDescription'],
        classWhatToExpect = json['ClassWhatToExpect'],
        classUserRequirements = json['ClassUserRequirements'],
        classType = stringToClassType(json['ClassType'][0]),
        classLocationName = json['ClassLocationName'],
        classLatitude = json['ClassLatitude'],
        classLongitude = json['ClassLongitude'],
        classRating = json['ClassRating'].toDouble(),
        classReview = json['ClassReview'],
        classPrice = json['ClassPrice'].toDouble(),
        classTrainer = json['ClassTrainer'],
        classLiked = json['ClassLiked'],
        trainerImageUrl = json['TrainerImageUrl'],
        trainerFirstName = json['TrainerFirstName'],
        trainerLastName = json['TrainerLastName'];

  Map<String, dynamic> toJson() => {
        'ClassName': className,
        'ClassImageUrl': classImageUrl,
        'ClassDescription': classDescription,
        'ClassWhatToExpect': classWhatToExpect,
        'ClassUserRequirements': classUserRequirements,
        'ClassType': classType.toString(),
        'ClassLocationName': classLocationName,
        'ClassLatitude': classLatitude,
        'ClassLongitude': classLongitude,
        'ClassRating': classRating,
        'ClassReview': classReview,
        'ClassPrice': classPrice,
        'ClassTrainer': classTrainer,
        'ClassLiked': classLiked,
        'TrainerImageUrl': trainerImageUrl,
        'TrainerFirstName': trainerFirstName,
        'TrainerLastName': trainerLastName
      };
}

//Semi-hardcoded casting from String to ClassType, not optimal but the best I can think of right now
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
  // Class(
  //     classImageUrl:
  //         'https://www.londonmagicaltours.com/img/Wimbledon-tennis-tours-1.jpg',
  //     className: 'Wimbledon Championship 2023 - Hosted by Patek Phillipe',
  //     classDescription:
  //         "Our mission is to champion opportunities for all. We use the collective strength of the All England Club and The Championships to make a positive difference to people's lives. - Respond in times of need by making a difference to those facing adversity.",
  //     classWhatToExpect:
  //         "The Foundation is governed by a board of seven Trustees with a wide range of charitable and business expertise and the day to day operations are managed by the Foundation team.",
  //     classUserRequirements:
  //         "There are a number of ways to buy Wimbledon tickets; these include purchasing long term debenture seats, the UK and overseas public ballots, queuing on the day or trying to purchase tickets the day before online.",
  //     classType: ClassType.Group,
  //     classLocation: "Toronto, Ontario",
  //     classRating: 4.6,
  //     classReview: 0,
  //     classPrice: 400,
  //     classLiked: false,
  //     classTimes: [],
  //     classTrainer: 'salmanjanvekar',
  //     trainerImageUrl:
  //         'https://firebasestorage.googleapis.com/v0/b/fitsy-5wx21.appspot.com/o/private%2Fvar%2Fmobile%2FContainers%2FData%2FApplication%2FC30AF58C-8871-4EF9-92C2-D3FA41E5A4B7%2Ftmp%2Fimage_picker_4C4728D4-1416-4F73-BA34-0E3C86ABBFDD-2819-0000024C398674C2.jpg?alt=media&token=1299217a-1d3e-48cf-9180-f28a1e8c58f6',
  //     trainerFirstName: 'Salman',
  //     trainerLastName: 'Janvekar'),
];
