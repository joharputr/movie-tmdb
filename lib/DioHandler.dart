import 'package:dio/dio.dart';

class DioHandler {
  Dio get dio => _dio();

  Dio _dio() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: "https://api.themoviedb.org/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    Dio dio = Dio(dioOptions);
    dio.interceptors.add(LogInterceptor(responseBody: true));
    return dio;
  }
}
