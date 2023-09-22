import 'package:balance/feModels/FollowerModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class FollowerRequests {
  Dio dio = new Dio();

  //Create Follower
  addFollower(String followerUserID, String userID) async {
    try {
      return await dio.post('$urlDomain/addFollower',
          data: {
            "FollowerUserID": followerUserID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Remove Follower
  removeFollower(String followerUserID, String userID) async {
    try {
      return await dio.get('$urlDomain/removeFollower',
          data: {
            "FollowerUserID": followerUserID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get Follower List
  getFollowerList(String username) async {
    try {
      return await dio.get(
        '$urlDomain/getFollowerList',
        queryParameters: {
          "Username": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  //NOTE - this has not been used yet
  getUserFollowing(String username) async {
    try {
      return await dio.get(
        '$urlDomain/getUserFollowing',
        queryParameters: {
          "Username": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
