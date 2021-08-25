abstract class BlocState {}

class FetchMovieData extends BlocState {
  final dynamic data;

  FetchMovieData({this.data});
}

class LoadingMovieData extends BlocState {}

class ErrorFetchData extends BlocState {}
