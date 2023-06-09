import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();

  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> postData({
    required url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      "lang": lang,
      "Authorization": token,
    };
    return await dio.get(url, queryParameters: query,);
  }
}
