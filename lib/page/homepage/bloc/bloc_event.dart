abstract class BlocEvent {}

class FetchTopMovie extends BlocEvent {
  final int? page;
  FetchTopMovie({this.page});
}

class FetchTopMovieLoadMore extends BlocEvent {
  final int? page;
  FetchTopMovieLoadMore({this.page});
}
