import 'dart:convert';
import 'package:balance/constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../feModels/ClassModel.dart';

class ClassRequests {
  Dio dio = new Dio();

  //Create class
  addClass(Class classModel) async {
    try {
      return await dio.post('$urlDomain/addclass',
          data: {
            "ClassName": classModel.className,
            "ClassImageUrl": classModel.classImageUrl,
            "ClassDescription": classModel.classDescription,
            "ClassWhatToExpect": classModel.classWhatToExpect,
            "ClassUserRequirements": classModel.classUserRequirements,
            "ClassType": classModel.classType.name,
            "ClassLocationName": classModel.classLocationName,
            "ClassLatitude": classModel.classLatitude,
            "ClassLongitude": classModel.classLongitude,
            "ClassOverallRating": classModel.classOverallRating,
            "ClassReviewsAmount": classModel.classReviewsAmount,
            "ClassPrice": classModel.classPrice,
            "ClassTrainerID": classModel.classTrainerID,
            "Categories": classModel.classCategories,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  getClass(List<String> classTrainer) async {
    final encodedArray = Uri.encodeComponent(jsonEncode(classTrainer));
    try {
      return await dio.get(
        '$urlDomain/getClasses',
        queryParameters: {
          "ClassTrainer": encodedArray,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  searchClasses(String searchIndex) async {
    try {
      return await dio.get(
        '$urlDomain/searchClasses',
        queryParameters: {
          "SearchIndex": searchIndex,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  addClassSchedule(String classTrainerID, DateTime startDate, DateTime endDate,
      String recurrence) async {
    try {
      return await dio.post(
        '$urlDomain/addClassTimes',
        data: {
          "ClassTrainerID": classTrainerID,
          "StartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
          "EndDate": DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
          "Recurrence": recurrence,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  changeClassSchedule(
      String classTrainerID,
      DateTime oldStartDate,
      DateTime oldEndDate,
      String oldRecurrence,
      DateTime newStartDate,
      DateTime newEndDate,
      String newRecurrence) async {
    try {
      return await dio.post(
        '$urlDomain/changeClassTimes',
        data: {
          "ClassTrainerID": classTrainerID,
          "OldStartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(oldStartDate.toUtc()),
          "OldEndDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(oldEndDate.toUtc()),
          "OldRecurrence": oldRecurrence,
          "NewStartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(newStartDate.toUtc()),
          "NewEndDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(newEndDate.toUtc()),
          "NewRecurrence": newRecurrence,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  removeClassSchedule(String classTrainerID, DateTime startDate,
      DateTime endDate, String recurrence) async {
    try {
      return await dio.post(
        '$urlDomain/removeClassTimes',
        data: {
          "ClassTrainerID": classTrainerID,
          "StartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
          "EndDate": DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
          "Recurrence": recurrence,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
