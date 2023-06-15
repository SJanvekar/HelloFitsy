import 'package:balance/feModels/classReviewModel.dart';
import 'package:dio/dio.dart';
import 'package:balance/constants.dart';

class ClassLikedRequests {
  Dio dio = new Dio();

  //Create Class Review
  addClassReview(ClassReview classReviewModel) async {
    try {
      return await dio.post('$urlDomain/addClassReview',
          data: {
            "ClassName": classReviewModel.className,
            "ClassImageUrl": classReviewModel.trainerName,
            "ClassType": classReviewModel.traineeName,
            "ClassLocation": classReviewModel.rating,
            "ClassTrainer": classReviewModel.dateSubmitted,
            "TrainerImageUrl": classReviewModel.reviewTitle,
            "TrainerFirstName": classReviewModel.reviewBody,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  //Get List of Liked Classes
  getClassReviewList(String username) async {
    try {
      return await dio.get(
        '$urlDomain/getClassReviewList',
        queryParameters: {
          "UserName": username,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
