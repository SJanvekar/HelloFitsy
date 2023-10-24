import 'dart:convert';
import 'package:balance/constants.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../feModels/ClassModel.dart';

class ScheduleRequests {
  Dio dio = new Dio();

  addClassSchedule(String classID, DateTime startDate, DateTime endDate,
      String recurrence) async {
    try {
      return await dio.post(
        '$urlDomain/addClassTimes',
        data: {
          "ClassID": classID,
          "StartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
          "EndDate": DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
          "Recurrence": recurrence,
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  changeClassSchedule(String classID, String scheduleID, DateTime newStartDate,
      DateTime newEndDate, String newRecurrence) async {
    try {
      return await dio.post(
        '$urlDomain/changeClassTimes',
        data: {
          "ClassID": classID,
          "ScheduleID": scheduleID,
          "NewStartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(newStartDate.toUtc()),
          "NewEndDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(newEndDate.toUtc()),
          "NewRecurrence": newRecurrence,
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  removeClassSchedule(
    String classID,
    String scheduleID,
  ) async {
    try {
      return await dio.post(
        '$urlDomain/removeClassTimes',
        data: {
          "ClassID": classID,
          "ScheduleID": scheduleID,
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  addUpdatedClassSchedule(
    String classID,
    String scheduleID,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      return await dio.post(
        '$urlDomain/addUpdatedClassTimes',
        data: {
          "ClassID": classID,
          "ScheduleReference": scheduleID,
          "StartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
          "EndDate": DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  removeUpdatedClassSchedule(
    String classID,
    String scheduleID,
  ) async {
    try {
      return await dio.post(
        '$urlDomain/removeUpdatedClassTimes',
        data: {
          "ClassID": classID,
          "ScheduleID": scheduleID,
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  addCancelledClassSchedule(
    String classID,
    String scheduleID,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      return await dio.post(
        '$urlDomain/addCancelledClassTimes',
        data: {
          "ClassID": classID,
          "ScheduleReference": scheduleID,
          "StartDate":
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(startDate.toUtc()),
          "EndDate": DateFormat("yyyy-MM-ddTHH:mm:ss").format(endDate.toUtc()),
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }

  removeCancelledClassSchedule(
    String classID,
    String scheduleID,
  ) async {
    try {
      return await dio.post(
        '$urlDomain/removeCancelledClassTimes',
        data: {
          "ClassID": classID,
          "ScheduleID": scheduleID,
        },
      );
    } on DioException catch (e) {
      print(e);
    }
  }
}
