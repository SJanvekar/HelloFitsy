import 'package:balance/feModels/ClassLikedModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class ClassLikedRequests {
  Dio dio = new Dio();

  addOrRemoveClassLiked(String userID, String classID, bool classLiked) async {
    try {
      return await dio.post(
          '$urlDomain/${classLiked ? 'addClassLiked' : 'removeClassLiked'}',
          data: {
            "UserID": userID,
            "ClassID": classID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  isLiked(String userID, String classID) async {
    try {
      return await dio.get('$urlDomain/isLiked',
          queryParameters: {
            "UserID": userID,
            "ClassID": classID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get List of Liked Classes
  getClassLikedList(String userID, String classID) async {
    try {
      return await dio.get(
        '$urlDomain/getClassLikedList',
        queryParameters: {
          "UserID": userID,
          "ClassID": classID,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
