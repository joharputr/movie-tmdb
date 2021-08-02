import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/local_storage/local_movie_model.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class MovieDetail extends StatefulWidget {
  final ResultUpcomingMovie? resultUpcomingMovie;

  MovieDetail({this.resultUpcomingMovie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final DbHelper _helper = new DbHelper();
  LocalMovieModel localMovieModel = LocalMovieModel();
  ResultUpcomingMovie? tempData;

  @override
  void initState() {
    tempData = this.widget.resultUpcomingMovie;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text("${this.widget.resultUpcomingMovie?.title}"),
            MaterialButton(
              onPressed: () {
                _helper.insert(
                    DbHelper.TABLE_NAME,
                    localMovieModel.toMap(
                        id: tempData?.id,
                        rating: ((tempData!.voteAverage)! ~/ 2).toInt(),
                        name: tempData?.title,
                        image:
                            'https://image.tmdb.org/t/p/w500${tempData?.posterPath}'));
              },
              color: Colors.blue,
              padding: EdgeInsets.all(6.0),
              child: Text("Press"),
            )
          ],
        ),
      ),
    );
  }
}
