import 'package:dio/dio.dart';

import '../../../feModels/userModel.dart';

class AuthService {
  Dio dio = new Dio();

  signIn(account, password) async {
    try {
      return await dio.post('http://localhost:8888/authenticate',
          data: {
            "Username": account,
            "Password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  getUserInfo(token, account) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      return await dio.get(
        'http://localhost:8888/getinfo',
        queryParameters: {"Account": account},
      );
    } on DioError catch (e) {
      print(e);
    }
  }

  signUp(User userModel) async {
    try {
      return await dio.post('http://localhost:8888/adduser',
          data: {
            "ProfileImageURL": userModel.profileImageURL,
            "UserType": userModel.userType.name,
            "IsActive": userModel.isActive,
            "FirstName": userModel.firstName,
            "LastName": userModel.lastName,
            "Username": userModel.userName,
            "UserEmail": userModel.userEmail,
            "Password": userModel.password,
            "Categories": userModel.categories,
            "LikedClasses": userModel.likedClasses,
            "ClassHistory": userModel.classHistory,
            "Following": userModel.following,
            "Followers": userModel.followers
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (status) => true,
          ));
    } on DioError catch (e) {
      print("SignUp Error: ${e}");
    }
  }
}
