import 'dart:convert';

PopularTvSeriesModel popularTvSeriesModelFromJson(str) =>
    PopularTvSeriesModel.fromJson(str);

String popularTvSeriesModelToJson(PopularTvSeriesModel data) =>
    json.encode(data.toJson());

class PopularTvSeriesModel {
  PopularTvSeriesModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<TopTvResult> results;
  final int totalPages;
  final int totalResults;

  factory PopularTvSeriesModel.fromJson(Map<String, dynamic> json) =>
      PopularTvSeriesModel(
        page: json["page"],
        results: List<TopTvResult>.from(
            json["results"].map((x) => TopTvResult.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class TopTvResult {
  TopTvResult({
    this.backdropPath,
    this.original_title,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final String? original_title;
  final String? firstAirDate;
  final List<int>? genreIds;
  final int? id;
  final String? name;
  final dynamic originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  factory TopTvResult.fromJson(Map<String, dynamic> json) => TopTvResult(
        backdropPath:
            json["backdrop_path"] == null ? "" : json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        originCountry: json["origin_country"] == null
            ? ""
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() =>
      {
        "backdrop_path": backdropPath,
        "original_title": original_title,
        "first_air_date": firstAirDate,
        "genre_ids": List<int>.from(genreIds!.map((x) => x)),
        "id": id,
        "name": name,
        "origin_country": List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
