import 'package:favorite_movie/bloc/bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/local_storage/db_helper.dart';

import 'bloc_state.dart';

import 'package:movie/local_storage/local_movie_model.dart';

class FavoriteMovieBloc extends Bloc<BlocEvent, BlocState> {
  FavoriteMovieBloc() : super(LoadingMovieData());

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    final DbHelper _helper = new DbHelper();

    if (event is SavedMovieData) {
      yield LoadingMovieData();

      try {
        yield FetchMovieData(data: await _helper.getData(DbHelper.TABLE_NAME));
      } catch (e) {
        print("errorFavoriteData = ${e.toString()}");
      }
    }
  }
}
