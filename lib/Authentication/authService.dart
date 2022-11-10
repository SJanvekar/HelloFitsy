import 'package:balance/constants.dart';
import 'package:balance/screen/login/login.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../feModels/userModel.dart';

class AuthService {
  Dio dio = new Dio();

  signIn(account, password) async {
    try {
      return await dio.post('http://www.fitsy.ca/authenticate',
          data: {
            "Username": account,
            "Password": password,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response?.data['msg'],
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: strawberry,
          textColor: snow,
          fontSize: 15.0);
    }
  }

  signUp(User userModel) async {
    try {
      print("ImageURL: $userModel.profileImageURL");
      return await dio.post('http://www.fitsy.ca/adduser',
          data: {
            "IsActive": userModel.isActive,
            "ProfileImageURL": userModel.profileImageURL,
            "UserType": userModel.userType,
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


// Widget unsuccessfulSignInTemp() {
//   return Container(
//     height: 50,
//     width: 323,
//     decoration: BoxDecoration(
//         color: snow,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: jetBlack.withOpacity(0.01),
//             spreadRadius: 0,
//             blurRadius: 38,
//             offset: Offset(0, 24), // changes position of shadow
//           ),
//           BoxShadow(
//             color: jetBlack.withOpacity(0.06),
//             spreadRadius: 0,
//             blurRadius: 46,
//             offset: Offset(0, 9), // changes position of shadow
//           ),
//           BoxShadow(
//             color: jetBlack.withOpacity(0.10),
//             spreadRadius: 0,
//             blurRadius: 15,
//             offset: Offset(0, 11), // changes position of shadow
//           ),
//         ]),
//     child: Center(
//         child: Text(
//       'Incorrect username or password  👀 ',
//       style: TextStyle(
//           color: Color(0xff7A7D81),
//           fontSize: 15,
//           fontFamily: 'SFDisplay',
//           letterSpacing: 0.5,
//           fontWeight: FontWeight.w600),
//     )),
//   );
// }

//   SnackBar(
//         content: Padding(
//           padding: const EdgeInsets.only(bottom: 320.0),
//           child: unsuccessfulSignInTemp(),
//         ),
//         behavior: SnackBarBehavior.floating,
//         duration: Duration(seconds: 2),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       );