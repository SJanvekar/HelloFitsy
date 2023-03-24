import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class UserRequests {
  Dio dio = new Dio();

  updateUserInformation(
      String firstName, String lastName, String userName) async {
    try {
      return await dio.put('$urlDomain/updateUserInfo', data: {
        "FirstName": firstName,
        "LastName": lastName,
        "Username": userName,
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
