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
    } on DioException catch (e) {
      print(e);
    }
  }

  getClasses(List<String> classID) async {
    final encodedArray = Uri.encodeComponent(jsonEncode(classID));
    try {
      return await dio.get(
        '$urlDomain/getClasses',
        queryParameters: {
          "ClassID": encodedArray,
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  getClassFromTrainer(List<String> classTrainer) async {
    final encodedArray = Uri.encodeComponent(jsonEncode(classTrainer));
    try {
      return await dio.get(
        '$urlDomain/getClassesFromTrainer',
        queryParameters: {
          "ClassTrainer": encodedArray,
        },
      );
    } on DioException catch (e) {
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
    } on DioException catch (e) {
      print(e);
    }
  }
}
