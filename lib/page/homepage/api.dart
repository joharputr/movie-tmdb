import 'package:dio/dio.dart';
import 'package:movie/page/homepage/model/popular_tv_series_model.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class Api {
  final Dio dio;
  Api({required this.dio});

  Future<dynamic> getTopMovie({required int? page}) async {
    print("pagee= $page");
    try {
      final url =
          "3/movie/top_rated?api_key=9b3efc88fed3cb0e25a0849788f05166&language=en-US&page=$page";
      final response = await dio.get(url);
      print("responseeeTopMovie = ${response.data}");
      return upCommingMovieFromJson(response.data);
    } on DioError catch (e) {
      print("error = ${e.response?.statusCode.toString()}");
      return e.message;
    }
  }

  Future<dynamic> getPopularTvSeries({required int? page}) async {
    try {
      final url =
          "3/tv/popular?api_key=9b3efc88fed3cb0e25a0849788f05166&language=en-US&page=$page";
      final response = await dio.get(url);
      print("popularMovie = ${response.data}");
      return popularTvSeriesModelFromJson(response.data);
    } on DioError catch (e) {
      print("error = ${e.toString()}");
      return e.message;
    }
  }
}
