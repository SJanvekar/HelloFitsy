import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

enum ClassType { Solo, Group, Virtual }

class ClassLiked {
  String userName;
  String classImageUrl;
  String className;
  ClassType classType;
  String classLocation;
  String classTrainer;
  String trainerFirstName;
  String trainerLastName;
  String trainerImageUrl;

  ClassLiked({
    required this.userName,
    required this.classImageUrl,
    required this.className,
    required this.classType,
    required this.classLocation,

    //Trainer Info
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.trainerFirstName,
    required this.trainerLastName,
    // required this.trainerUsername,
  });
}
