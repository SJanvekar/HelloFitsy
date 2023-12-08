import 'package:balance/feModels/NotificationModel.dart';
import 'package:balance/screen/login/components/PersonalInfo.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationRequests {
  Dio dio = new Dio();

  // void onDidReceiveNotificationResponse(
  //     NotificationResponse notificationResponse) async {
  //   final String? payload = notificationResponse.payload;
  //   if (notificationResponse.payload != null) {
  //     print('notification payload: $payload');
  //   }
  //   await Navigator.of(context).push(CupertinoPageRoute(
  //       fullscreenDialog: false, builder: (context) => PersonalInfo()));
  // }

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
