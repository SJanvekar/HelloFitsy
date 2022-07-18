import 'package:balance/constants.dart';
import 'package:balance/screen/login/login.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  addClass(className, classType, classLocation, classRating, classReview,
      classPrice, classTrainer, classLiked) async {
    try {
      return await dio.post('http://www.fitsy.ca/addclass',
          data: {
            "ClassName": className,
            "ClassType": classType,
            "ClassLocation": classLocation,
            "ClassRating": classRating,
            "ClassReview": classReview,
            "ClassPrice": classPrice,
            "ClassTrainer": classTrainer,
            "ClassLiked": classLiked,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e);
    }
  }
}
