import 'package:balance/constants.dart';
import 'package:dio/dio.dart';
import '../feModels/ClassModel.dart';

class ClassRequests {
  Dio dio = new Dio();

  //Create class
  addClass(Class classModel) async {
    try {
      return await dio.post('$urlDomain/addclass',
          data: {
            "ClassName": classModel.className,
            "ClassImageUrl": classModel.classImageUrl,
            "ClassDescription": classModel.classDescription,
            "ClassWhatToExpect": classModel.classWhatToExpect,
            "ClassUserRequirements": classModel.classUserRequirements,
            "ClassType": classModel.classType.name,
            "ClassLocationName": classModel.classLocationName,
            "ClassLatitude": classModel.classLatitude,
            "ClassLongitude": classModel.classLongitude,
            "ClassReviewsAmount": classModel.classReviewsAmount,
            "ClassPrice": classModel.classPrice,
            "ClassTrainer": classModel.classTrainer,
            "Categories": classModel.classCategories,
            "TrainerImageUrl": classModel.trainerImageUrl,
            "TrainerFirstName": classModel.trainerFirstName,
            "TrainerLastName": classModel.trainerLastName,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  getClass(List<dynamic> classTrainer) async {
    try {
      return await dio.get(
        '$urlDomain/getClasses',
        queryParameters: {
          "ClassTrainer": classTrainer,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
