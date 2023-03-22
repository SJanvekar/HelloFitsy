import 'package:dio/dio.dart';

class UserRequests {
  Dio dio = new Dio();

  updateUserInformation(
      String firstName, String lastName, String userName) async {
    try {
      return await dio.put('http://localhost:8888/updateUserInfo', data: {
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
        'http://localhost:8888/getUserFollowing',
        queryParameters: {
          "Username": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
