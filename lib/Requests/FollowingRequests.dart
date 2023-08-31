import 'package:balance/feModels/FollowingModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class FollowingRequests {
  Dio dio = new Dio();

  //Create Following
  addFollowing(Following followingModel) async {
    try {
      return await dio.post('$urlDomain/addFollowing',
          data: {
            "FollowingUserName": followingModel.followingUsername,
            "Username": followingModel.username,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Remove Following
  removeFollowing(String followingUsername, String username) async {
    try {
      return await dio.get('$urlDomain/removeFollowing',
          data: {
            "FollowingUserName": followingUsername,
            "Username": username,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Remove Following
  isFollowing(String followingUsername, String username) async {
    try {
      return await dio.get('$urlDomain/isFollowing',
          data: {
            "FollowingUserName": followingUsername,
            "Username": username,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get Following List
  getFollowingList(String username) async {
    try {
      return await dio.get(
        '$urlDomain/getFollowingList',
        queryParameters: {
          "Username": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
