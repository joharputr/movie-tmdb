import 'package:flutter/foundation.dart';

abstract class BlocState {}

class BlocEmpty extends BlocState {}

class BlocError extends BlocState {
  final String error;

  BlocError(this.error);
}

class BlocLoading extends BlocState {}

class BlocLoaded extends BlocState {
  final dynamic data;

  BlocLoaded(this.data);
}
