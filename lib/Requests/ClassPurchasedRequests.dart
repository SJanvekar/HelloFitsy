import 'package:dio/dio.dart';
import 'package:balance/constants.dart';
import 'package:intl/intl.dart';

class ClassPurchasedRequests {
  Dio dio = new Dio();

  //Add Class Purchased
  addClassPurchased(String classID, String userID, DateTime startDate,
      DateTime endDate, DateTime dateBooked, double pricePaid) async {
    try {
      //TODO: Implement federal and provincial tax rates for price paid
      return await dio.post('$urlDomain/addClassPurchased',
          data: {
            "ClassID": classID,
            "UserID": userID,
            "StartDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
            "EndDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
            "DateBooked":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(dateBooked.toUtc()),
            "PricePaid": pricePaid,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Add Class Purchased Updated Schedule
  addClassPurchasedUpdatedSchedule(String classID, String userID,
      DateTime startDate, DateTime endDate, String scheduleReference) async {
    try {
      return await dio.post('$urlDomain/addClassPurchasedUpdatedSchedule',
          data: {
            "ClassID": classID,
            "UserID": userID,
            "StartDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
            "EndDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
            "ScheduleReference": scheduleReference,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Change Class Purchased Updated Schedule
  changeClassPurchasedUpdatedSchedule(
      String classID,
      String userID,
      String scheduleID,
      DateTime startDate,
      DateTime endDate,
      String scheduleReference) async {
    try {
      return await dio.post('$urlDomain/changeClassPurchasedUpdatedSchedule',
          data: {
            "ClassID": classID,
            "UserID": userID,
            "ScheduleID": scheduleID,
            "StartDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
            "EndDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
            "ScheduleReference": scheduleReference,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Add Class Purchased Cancelled Schedule
  addClassPurchasedCancelledSchedule(String classID, String userID,
      DateTime startDate, DateTime endDate, String scheduleReference) async {
    try {
      return await dio.post('$urlDomain/addClassPurchasedCancelledSchedule',
          data: {
            "ClassID": classID,
            "UserID": userID,
            "StartDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
            "EndDate":
                DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
            "ScheduleReference": scheduleReference,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Add Class Missed
  addClassPurchasedMissed(String classID, String userID) async {
    try {
      return await dio.post('$urlDomain/addClassPurchasedMissed',
          data: {"ClassID": classID, "UserID": userID},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //TODO: Maybe we add cancellation reason for this too
  //Add Class Cancelled
  addClassPurchasedCancelled(String classID, String userID) async {
    try {
      return await dio.post('$urlDomain/addClassPurchasedCancelled',
          data: {"ClassID": classID, "UserID": userID},
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Add Class Cancellelation Reason
  addClassPurchasedCancelReason(
      String classID, String userID, String cancellationReason) async {
    try {
      return await dio.post('$urlDomain/addClassPurchasedCancelReason',
          data: {
            "ClassID": classID,
            "UserID": userID,
            "CancellationReason": cancellationReason
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get Class Purchased
  getClassPurchased(String? classID, String? userID) async {
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
