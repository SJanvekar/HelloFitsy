import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class UserRequests {
  Dio dio = new Dio();

  updateUserInformation(
      String? profileImageURL,
      String? oldUsername,
      String? firstName,
      String? lastName,
      String? newUserName,
      String? bio) async {
    try {
      return await dio.put('$urlDomain/updateUserInfo', data: {
        "OldUsername": oldUsername,
        "ProfileImageURL": profileImageURL,
        "FirstName": firstName,
        "LastName": lastName,
        "NewUsername": newUserName,
        "UserBio": bio,
      });
    } on DioError catch (e) {
      print(e);
    }
  }

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
