abstract class BlocState {}

class  SearchData extends BlocState {
  final dynamic data;

  SearchData({this.data});
}

class LoadingSearchData extends BlocState {}

class ErrorSearchData extends BlocState {}