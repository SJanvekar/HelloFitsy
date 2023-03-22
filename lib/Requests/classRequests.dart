import 'package:balance/constants.dart';
import 'package:balance/screen/login/login.dart';
import 'package:dio/dio.dart';
import '../../../feModels/classModel.dart';

class ClassRequests {
  Dio dio = new Dio();

  //Create class
  addClass(Class classModel) async {
    try {
      return await dio.post('http://www.fitsy.ca/addclass',
          data: {
            "ClassName": classModel.className,
            "ClassImageUrl": classModel.classImageUrl,
            "ClassDescription": classModel.classDescription,
            "ClassWhatToExpect": classModel.classWhatToExpect,
            "ClassUserRequirements": classModel.classUserRequirements,
            "ClassType": classModel.classType.name,
            "ClassLocation": classModel.classLocation,
            "ClassRating": classModel.classRating,
            "ClassReview": classModel.classReview,
            "ClassPrice": classModel.classPrice,
            "ClassTrainer": classModel.classTrainer,
            "ClassLiked": classModel.classLiked,
            "ClassTimes": classModel.classTimes,
            "Categories": classModel.classCategories,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }

  getClass(List<dynamic> classTrainer) async {
    try {
      return await dio.get(
        'http://localhost:8888/getClasses',
        queryParameters: {
          "ClassTrainer": classTrainer,
        },
      );
    } on DioError catch (e) {
      print(e);
    }
  }
}
