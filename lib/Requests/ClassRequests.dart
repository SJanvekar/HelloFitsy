import 'dart:convert';
import 'package:balance/constants.dart';
import 'package:dio/dio.dart';
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

  addClassSchedule(String classTrainerID, String startDate, String endDate,
      String recurrence) async {
    try {
      return await dio.get(
        '$urlDomain/addClassTimes',
        queryParameters: {
          "ClassTrainerID": classTrainerID,
          "StartDate": startDate,
          "EndDate": endDate,
          "Recurrence": recurrence,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  changeClassSchedule(
      String classTrainerID,
      String oldStartDate,
      String oldEndDate,
      String oldRecurrence,
      String newStartDate,
      String newEndDate,
      String newRecurrence) async {
    try {
      return await dio.get(
        '$urlDomain/changeClassTimes',
        queryParameters: {
          "ClassTrainerID": classTrainerID,
          "NewStartDate": newStartDate,
          "NewEndDate": newEndDate,
          "NewRecurrence": newRecurrence,
          "OldStartDate": oldStartDate,
          "OldEndDate": oldEndDate,
          "OldRecurrence": oldRecurrence,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  removeClassSchedule(String classTrainerID, String startDate, String endDate,
      String recurrence) async {
    try {
      return await dio.get(
        '$urlDomain/removeClassTimes',
        queryParameters: {
          "ClassTrainerID": classTrainerID,
          "StartDate": startDate,
          "EndDate": endDate,
          "Recurrence": recurrence,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
