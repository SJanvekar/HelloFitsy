import 'package:balance/feModels/FollowerModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class FollowerRequests {
  Dio dio = new Dio();

  //Create Follower
  addFollower(Follower followerModel) async {
    try {
      return await dio.post('$urlDomain/addFollower',
          data: {
            "FollowerUserName": followerModel.followerUsername,
            "Username": followerModel.username,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Remove Follower
  removeFollower(String followerUsername, String username) async {
    try {
      return await dio.get('$urlDomain/removeFollower',
          data: {
            "FollowerUserName": followerUsername,
            "Username": username,
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
}
