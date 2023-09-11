import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class StripeRequests {
  Dio dio = new Dio();

  //Get Follower List
  createStripeAccount(String username) async {
    try {
      return await dio.get(
        '$urlDomain/createStripeAccount',
        queryParameters: {
          "Username": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
