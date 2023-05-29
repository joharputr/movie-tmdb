import 'package:favorite_movie/bloc/bloc_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/local_storage/local_movie_model.dart';

import 'bloc_state.dart';

class FavoriteMovieBloc extends Bloc<BlocEvent, BlocState> {
  DbHelper dbHelper;

  FavoriteMovieBloc({required this.dbHelper}) : super(LoadingMovieData());

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is SavedMovieData) {
      yield LoadingMovieData();

      try {
        yield FetchMovieData(data: await dbHelper.getData(DbHelper.TABLE_NAME));
      } catch (e) {
        print("errorFavoriteData = ${e.toString()}");
      }
    }
  }
}
