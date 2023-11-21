import 'package:balance/feModels/NotificationModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class NotificationRequests {
  Dio dio = new Dio();

  //Create Test Notification
  addTestNotification(String registrationToken) async {
    try {
      return await dio.post('$urlDomain/addTestNotification',
          data: {
            "RegistrationToken": registrationToken,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }
}
