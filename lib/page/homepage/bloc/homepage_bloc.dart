import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/page/homepage/api.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class TopMovieBloc extends Bloc<BlocEvent, BlocState> {
  TopMovieBloc() : super(BlocLoading());

  int page = 1;

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    Api api = Api();
    if (event is FetchTopMovie) {
      yield BlocLoading(); //state
      try {
        dynamic getRepoData = await api.getTopMovie(page: page);
        print("getRepoo = $getRepoData");
        if (getRepoData is UpCommingMovie) {
          yield BlocLoaded(getRepoData);
        } else
          yield BlocError(getRepoData);
      } catch (_) {
        yield BlocError("error Bro");
      }
    } else if (event is FetchTopMovieLoadMore) {
      yield BlocLoadingMore(); //state
      try {
        page++;
        dynamic getRepoData = await api.getTopMovie(page: page);
        if (getRepoData is UpCommingMovie) {
          yield BlocLoaded(getRepoData);
        } else
          yield BlocError(getRepoData);
        print("getRepoData = ${getRepoData}");
      } catch (_) {
        yield BlocError("error Bro");
      }
    }
  }
}
