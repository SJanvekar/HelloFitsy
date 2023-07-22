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
            "UserName": classHistoryModel.userName,
            "ClassName": classHistoryModel.className,
            "ClassImageUrl": classHistoryModel.classImageUrl,
            "ClassType": classHistoryModel.classType.name,
            "ClassLocation": classHistoryModel.classLocation,
            "ClassTrainer": classHistoryModel.classTrainer,
            "TrainerImageUrl": classHistoryModel.trainerImageUrl,
            "TrainerFirstName": classHistoryModel.trainerFirstName,
            "TrainerLastName": classHistoryModel.trainerLastName,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get List of Liked Classes
  getClassHistoryList(String username) async {
    try {
      return await dio.get(
        '$urlDomain/getClassHistoryList',
        queryParameters: {
          "UserName": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
