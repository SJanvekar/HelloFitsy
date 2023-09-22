import 'package:balance/feModels/FollowingModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class FollowingRequests {
  Dio dio = new Dio();

  //Create Following
  addFollowing(String followingUserID, String userID) async {
    try {
      return await dio.post('$urlDomain/addFollowing',
          data: {
            "FollowingUserID": followingUserID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Remove Following
  removeFollowing(String followingUserID, String userID) async {
    try {
      return await dio.get('$urlDomain/removeFollowing',
          data: {
            "FollowingUserID": followingUserID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Remove Following
  isFollowing(String followingUserID, String userID) async {
    try {
      return await dio.get('$urlDomain/isFollowing',
          data: {
            "FollowingUserID": followingUserID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get Following List
  getFollowingList(String userID) async {
    try {
      return await dio.get(
        '$urlDomain/getFollowingList',
        queryParameters: {
          "UserID": userID,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
