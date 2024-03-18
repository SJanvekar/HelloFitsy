import 'package:balance/feModels/ClassHistoryModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class ClassHistoryRequests {
  Dio dio = new Dio();

  //Create Class History
  addClassHistory(ClassHistory classHistoryModel) async {
    try {
      return await dio.post('$urlDomain/addClassHistory',
          data: {
            "UserID": classHistoryModel.userID,
            "ClassID": classHistoryModel.classID,
            "DateTaken": classHistoryModel.dateTaken,
            "TakenStartTimes": classHistoryModel.takenStartTimes,
            "IsMissed": classHistoryModel.isMissed,
            "IsCancelled": classHistoryModel.isCancelled,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get List of Liked Classes
  getClassHistoryList(String userID) async {
    try {
      return await dio.get(
        '$urlDomain/getClassHistoryList',
        queryParameters: {
          "UserID": userID,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
