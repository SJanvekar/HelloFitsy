import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

import '../../../feModels/userModel.dart';

class UserRequests {
  Dio dio = new Dio();

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
