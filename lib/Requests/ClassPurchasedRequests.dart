import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class ClassPurchasedRequests {
  Dio dio = new Dio();

  //Add Class Purchased
  addClassPurchased(String classID, String userID) async {
    try {
      return await dio.post('$urlDomain/addClassPurchased',
          data: {
            "ClassID": classID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get Class Purchased
  getClassPurchased(String classID, String userID) async {
    try {
      return await dio.get('$urlDomain/getClassPurchased',
          queryParameters: {
            "ClassID": classID,
            "UserID": userID,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }
}
