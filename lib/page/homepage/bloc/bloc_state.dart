import 'package:flutter/foundation.dart';

abstract class BlocState {}

class BlocEmpty extends BlocState {}

class BlocError extends BlocState {
  final String error;

  BlocError(this.error);
}

class BlocLoadingTopMovie extends BlocState {}

class BlocLoadingMoreTopMovie extends BlocState {}

class BlocLoadedTopMovie extends BlocState {
  final dynamic data;

  BlocLoadedTopMovie(this.data);
}

class BlocLoadingTvSeries extends BlocState {}

class BlocLoadingMoreTvSeries extends BlocState {}

class BlocLoadedTvSeries extends BlocState {
  final dynamic data;

  BlocLoadedTvSeries(this.data);
}
