import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';

class DetailMovieBloc extends Bloc<BlocEvent, BlocState> {
  //initial
  DetailMovieBloc() : super(BLocLoadingDetailMovie());

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    final DbHelper _helper = new DbHelper();
    if (event is FetchDetailMovie) {
      try {
        yield BlocDetailMovie(data: await _helper.getData(DbHelper.TABLE_NAME));
      } catch (e) {
        print('errorDeleteFav = ${e.toString()}');
      }
    }
  }
}
