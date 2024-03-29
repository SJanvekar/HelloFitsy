import 'package:balance/feModels/AuthModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

import '../feModels/UserModel.dart';

class AuthService {
  Dio dio = new Dio();

  signIn(account, password) async {
    try {
      return await dio.post('$urlDomain/authenticate',
          data: {
            "Username": account,
            "Password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } catch (e) {
      print("Authenticate/Sign In errors: ${e}");
    }
  }

  getLogInInfo(token, account) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      return await dio.get(
        '$urlDomain/getLogInInfo',
        queryParameters: {"Account": account},
      );
    } catch (e) {
      print("Get User Info Error: ${e}");
    }
  }

  signUp(Auth authModel, User userModel) async {
    try {
      return await dio.post('$urlDomain/adduser',
          data: {
            "ProfileImageURL": userModel.profileImageURL,
            "UserType": userModel.userType.name,
            "IsActive": userModel.isActive,
            "FirstName": userModel.firstName,
            "LastName": userModel.lastName,
            "Username": userModel.userName,
            "UserEmail": authModel.userEmail,
            "UserPhone": authModel.userPhone,
            "Password": authModel.password,
            "Categories": userModel.categories
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (status) => true,
          ));
    } catch (e) {
      print("SignUp Error: ${e}");
    }
  }
}
