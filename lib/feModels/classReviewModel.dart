import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

class ClassReview {
  String className;
  String trainerName;
  String traineeName;
  double rating;
  DateTime dateSubmitted;
  String reviewTitle;
  String reviewBody;

  ClassReview({
    required this.className,
    required this.trainerName,
    required this.traineeName,
    required this.rating,
    required this.dateSubmitted,
    required this.reviewTitle,
    required this.reviewBody,
  });
}
