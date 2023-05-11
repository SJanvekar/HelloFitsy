import 'package:balance/feModels/followerModel.dart';
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
            "FollowerFirstName": followerModel.followerFirstName,
            "FollowerLastName": followerModel.followerLastName,
            "FollowerProfileImageURL": followerModel.followerProfileImageURL,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

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
