import 'package:balance/feModels/followingModel.dart';
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
            "FollowingFirstName": followingModel.followingFirstName,
            "FollowingLastName": followingModel.followingLastName,
            "FollowingProfileImageURL": followingModel.followingProfileImageURL,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

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
