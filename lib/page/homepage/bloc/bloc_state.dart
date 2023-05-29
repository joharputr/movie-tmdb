import 'package:flutter/foundation.dart';

abstract class BlocState {}

class BlocEmpty extends BlocState {

}

class BlocError extends BlocState {
  final String error;

  BlocError(this.error);
}

//top movie
class BlocLoadingTopMovie extends BlocState {}

class BlocLoadingMoreTopMovie extends BlocState {}

class BlocLoadedTopMovie extends BlocState {
  final dynamic data;

  BlocLoadedTopMovie(this.data);
}

//tv series
class BlocLoadingTvSeries extends BlocState {}

class BlocLoadedTvSeries extends BlocState {
  final dynamic data;

  BlocLoadedTvSeries(this.data);
}


//detail movie
class BLocLoadingDetailMovie extends BlocState{}
class BlocDetailMovie extends BlocState {
  final dynamic data;

  BlocDetailMovie({this.data});
}
