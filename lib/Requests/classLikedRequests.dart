import 'package:balance/feModels/classLikedModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class ClassLikedRequests {
  Dio dio = new Dio();

  //Create Class Liked
  addClassLiked(ClassLiked classLikedModel) async {
    try {
      return await dio.post('$urlDomain/addClassLiked',
          data: {
            "UserName": classLikedModel.userName,
            "ClassName": classLikedModel.className,
            "ClassImageUrl": classLikedModel.classImageUrl,
            "ClassType": classLikedModel.classType.name,
            "ClassLocation": classLikedModel.classLocation,
            "ClassTrainer": classLikedModel.classTrainer,
            "TrainerImageUrl": classLikedModel.trainerImageUrl,
            "TrainerFirstName": classLikedModel.trainerFirstName,
            "TrainerLastName": classLikedModel.trainerLastName,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get List of Liked Classes
  getClassLikedList(String username) async {
    try {
      return await dio.get(
        '$urlDomain/getClassLikedList',
        queryParameters: {
          "UserName": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
