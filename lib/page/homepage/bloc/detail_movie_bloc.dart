import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';

class DetailMovieBloc extends Bloc<BlocEvent, BlocState> {
  final DbHelper dbHelper;

  //initial
  DetailMovieBloc({required this.dbHelper}) : super(BLocLoadingDetailMovie());

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is FetchDetailMovie) {
      try {
        yield BlocDetailMovie(data: await dbHelper.getData(DbHelper.TABLE_NAME));
      } catch (e) {
        print('errorDeleteFav = ${e.toString()}');
      }
    }
  }
}
