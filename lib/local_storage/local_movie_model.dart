import 'dart:convert';

LocalMovieModel localMovieModelFromJson(str) => LocalMovieModel.fromJson(str);

String localMovieModelToJson(LocalMovieModel data) => json.encode(data.toMap());

class LocalMovieModel {
  int? id;
  String? name;
  String? image;
  int? rating;

  LocalMovieModel({this.id, this.image, this.name, this.rating, });

  factory LocalMovieModel.fromJson(Map<String, dynamic> json) {
    return LocalMovieModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        rating: json['rating']);
  }

  Map<String, dynamic> toMap(
      {int? id, String? name, String? image,int? rating}) {
    return {
      'id': id,
      'name': name,
      'image': image,
      'rating': rating
    };
  }
}
