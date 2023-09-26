import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class UserRequests {
  Dio dio = new Dio();

  updateUserInformation(
      String? profileImageURL,
      String? userID,
      String? firstName,
      String? lastName,
      String? newUserName,
      String? bio) async {
    try {
      return await dio.post('$urlDomain/updateUserInfo', data: {
        "UserID": userID,
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

  updateUserStripeAccountID(String? stripeAccountID, String? userName) async {
    try {
      return await dio.post('$urlDomain/updateUserStripeAccountID', data: {
        "StripeAccountID": stripeAccountID,
        "Username": userName,
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  updateUserStripeCustomerID(String? stripeCustomerID, String? userName) async {
    try {
      return await dio.post('$urlDomain/updateUserStripeCustomerID', data: {
        "StripeCustomerID": stripeCustomerID,
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

  searchTrainers(String searchIndex) async {
    try {
      return await dio.get(
        '$urlDomain/searchTrainers',
        queryParameters: {
          "SearchIndex": searchIndex,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  getUserInfo(String userID) async {
    try {
      return await dio.get(
        '$urlDomain/getUserInfo',
        queryParameters: {
          "UserID": userID,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  getClassTrainerInfo(String userID) async {
    try {
      return await dio.get(
        '$urlDomain/getClassTrainerInfo',
        queryParameters: {
          "UserID": userID,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
