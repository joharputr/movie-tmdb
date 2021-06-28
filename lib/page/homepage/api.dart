import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class Api {
  Dio dio = Dio();

  Future<dynamic> getTopMovie({required int? page}) async {
    print("pagee= $page");
    try {
      final url =
          "https://api.themoviedb.org/3/movie/top_rated?api_key=9b3efc88fed3cb0e25a0849788f05166&language=en-US&page=$page";
      final response = await dio.get(url);
      print("responseee = ${response.statusCode}");
      return upCommingMovieFromJson(response.data);
    } on DioError catch (e) {
      print("error = ${e.response?.statusCode.toString()}");
      return e.message;
    }
  }
}
