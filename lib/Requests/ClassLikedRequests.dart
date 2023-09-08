import 'package:balance/feModels/ClassLikedModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class ClassLikedRequests {
  Dio dio = new Dio();

  addOrRemoveClassLiked(
      String userName, String classID, bool classLiked) async {
    try {
      return await dio.post(
          '$urlDomain/${classLiked ? 'addClassLiked' : 'removeClassLiked'}',
          data: {
            "UserName": userName,
            "ClassID": classID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  isLiked(String userName, String classID) async {
    try {
      return await dio.get('$urlDomain/isLiked',
          queryParameters: {
            "UserName": userName,
            "ClassID": classID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get List of Liked Classes
  getClassLikedList(String userName, String classID) async {
    try {
      return await dio.get(
        '$urlDomain/getClassLikedList',
        queryParameters: {
          "UserName": userName,
          "ClassID": classID,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
