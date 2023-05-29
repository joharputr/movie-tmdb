import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/DioHandler.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/page/homepage/api.dart';
import 'package:movie/page/homepage/bloc/detail_movie_bloc.dart';
import 'package:movie/page/homepage/bloc/homepage_bloc.dart';

final locator = GetIt.instance;

class Dependency {
  void init() {
    _registerDb();
    _registerDio();
    _registerData();
    _registerViewModel();
  }

  void _registerDb() {
    locator.registerLazySingleton<DbHelper>(() => DbHelper());
  }

  void _registerDio() {
    locator.registerLazySingleton<Dio>(() => DioHandler().dio);
  }

  void _registerData() {
    locator.registerLazySingleton<Api>(() => Api(dio: locator()));
  }

  void _registerViewModel() {
    locator.registerLazySingleton(() => TopMovieBloc(api: locator()));
    locator.registerLazySingleton(() => DetailMovieBloc(dbHelper: locator()));
  }
}
