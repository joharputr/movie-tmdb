import 'dart:convert';

LocalMovieModel localMovieModelFromJson(str) => LocalMovieModel.fromJson(str);

String localMovieModelToJson(LocalMovieModel data) => json.encode(data.toMap());

class LocalMovieModel {
  int? id;
  String? name;
  String? image;
  int? rating;
  String? overview;

  LocalMovieModel({this.id, this.image, this.name, this.rating, this.overview});

  factory LocalMovieModel.fromJson(Map<String, dynamic> json) {
    return LocalMovieModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        rating: json['rating'],
        overview: json['overview']);
  }

  Map<String, dynamic> toMap(
      {int? id, String? name, String? image, int? rating,String? overview}) {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'overview': overview
    };
  }

  @override
  bool operator ==(Object other) => other is LocalMovieModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
