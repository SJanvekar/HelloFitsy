import 'package:balance/constants.dart';
import 'package:balance/screen/login/login.dart';
import 'package:dio/dio.dart';

class Requests {
  Dio dio = new Dio();

  getClassInfo(classType, classLocation, classRating, classReview, classPrice,
      classTrainer, classLiked) async {
    Response response;
    try {
      response = await dio.get('http://www.fitsy.ca/getClassInfo',
          options: Options(contentType: Headers.formUrlEncodedContentType));
      print(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  addClass(className, classDescription, classType, classLocation, classRating,
      classReview, classPrice, classTrainer, classLiked, classTimes) async {
    try {
      return await dio.post('http://www.fitsy.ca/addclass',
          data: {
            "ClassName": className,
            "ClassDescription": classDescription,
            "ClassType": classType,
            "ClassLocation": classLocation,
            "ClassRating": classRating,
            "ClassReview": classReview,
            "ClassPrice": classPrice,
            "ClassTrainer": classTrainer,
            "ClassLiked": classLiked,
            "ClassTimes": classTimes,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }
}
