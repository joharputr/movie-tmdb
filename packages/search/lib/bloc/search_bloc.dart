import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/di/dependency.dart';
import 'package:movie/page/homepage/api.dart';
import 'package:movie/page/homepage/model/popular_tv_series_model.dart';
import 'package:search/bloc/bloc_event.dart';
import 'package:search/bloc/bloc_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, BlocState> {
  Api api = Api(dio: locator());

  List<TopTvResult> resultTvSeries = [];

  SearchBloc({required this.api}) : super(LoadingSearchData());

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is SearchBlocEvent) {
      yield LoadingSearchData(); //state

      dynamic getRepoData = await api.searchMovie(text: event.text);
      if (getRepoData is PopularTvSeriesModel) {
        resultTvSeries.addAll(getRepoData.results);
        yield SearchData(data: resultTvSeries);
      } else
        yield ErrorSearchData();
    }
  }
}
