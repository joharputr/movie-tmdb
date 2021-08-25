import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/page/homepage/api.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/model/popular_tv_series_model.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class TopMovieBloc extends Bloc<BlocEvent, BlocState> {
  TopMovieBloc() : super(BlocLoadingTopMovie());
  int pageUpcomingMovie = 1;
  List<ResultUpcomingMovie>? resultUpcomingMovie = [];

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    Api api = Api();
    if (event is FetchTopMovie) {
  //    yield BlocLoadingTopMovie(); //state
      try {
        dynamic getRepoData = await api.getTopMovie(page: pageUpcomingMovie);
        print("getRepoo = ${getRepoData}");

        if (getRepoData is UpCommingMovie) {
          resultUpcomingMovie?.addAll(getRepoData.results!);

          yield BlocLoadedTopMovie(resultUpcomingMovie);
        } else
          yield BlocError(getRepoData);
      } catch (e) {
        yield BlocError("error Bro = $e");
      }
    } else if (event is FetchTopMovieLoadMore) {
      yield BlocLoadingMoreTopMovie(); //state
      try {
        pageUpcomingMovie++;
        dynamic getRepoData = await api.getTopMovie(page: pageUpcomingMovie);
        if (getRepoData is UpCommingMovie) {
          resultUpcomingMovie?.addAll(getRepoData.results!);
          yield BlocLoadedTopMovie(resultUpcomingMovie);
        } else
          yield BlocError(getRepoData);
        print("getRepoData = ${getRepoData}");
      } catch (_) {
        yield BlocError("error Bro");
      }
    }
  }
}

class TvBloc extends Bloc<BlocEvent, BlocState> {
  TvBloc() : super(BlocLoadingTvSeries());
  Api api = Api();
  int pageTvSeries = 1;
  List<TopTvResult> resultTvSeries = [];

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is FetchPopularTvSeries) {
      yield BlocLoadingTvSeries(); //state

        dynamic getRepoData = await api.getPopularTvSeries(page: pageTvSeries);
        if (getRepoData is PopularTvSeriesModel) {
          resultTvSeries.addAll(getRepoData.results);
          yield BlocLoadedTvSeries(resultTvSeries);
        } else
          yield BlocError(getRepoData);
      }
    }
  
}
