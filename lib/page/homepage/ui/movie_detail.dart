import 'package:flutter/material.dart';
import 'package:movie/helper/style.dart';
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
  List<LocalMovieModel> favData = [];

  @override
  void initState() {
    tempData = this.widget.resultUpcomingMovie;

    initData();
    super.initState();
  }

  void initData() {
    _helper.getData(DbHelper.TABLE_NAME).then((value) {
      value.forEach((element) {
        print("dataSved = $element");
        favData.add(LocalMovieModel.fromJson(element));
      });
      setState(() {});
      if (favData.contains(LocalMovieModel.fromJson(localMovieModel.toMap(
          id: tempData?.id,
          rating: ((tempData!.voteAverage)! ~/ 2).toInt(),
          name: tempData?.title,
          image: 'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
          overview: tempData?.overview)))) {
        print("trueee");
      } else {
        print('falseee');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Color(0xff1B1E25),
          elevation: 0,
        ),
        body: Container(
          color: Color(0xff1B1E25),
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Details Movie",
                      style: CustomStyle().fontStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.favorite,
                        color: favData.contains(LocalMovieModel.fromJson(
                                localMovieModel.toMap(
                                    id: tempData?.id,
                                    rating:
                                        ((tempData!.voteAverage)! ~/ 2).toInt(),
                                    name: tempData?.title,
                                    image:
                                        'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
                                    overview: tempData?.overview)))
                            ? Colors.red
                            : Colors.white,
                      ),
                      onTap: () {
                        if (favData.contains(LocalMovieModel.fromJson(
                            localMovieModel.toMap(
                                id: tempData?.id,
                                rating: ((tempData!.voteAverage)! ~/ 2).toInt(),
                                name: tempData?.title,
                                image:
                                    'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
                                overview: tempData?.overview)))) {
                          _helper
                              .delete(DbHelper.TABLE_NAME, tempData?.id)
                              .then((value) {
                            print("deletee = $value");
                          });
                        } else {
                          _helper.insert(
                            DbHelper.TABLE_NAME,
                            localMovieModel.toMap(
                                id: tempData?.id,
                                rating: ((tempData!.voteAverage)! ~/ 2).toInt(),
                                name: tempData?.title,
                                image:
                                    'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
                                overview: tempData?.overview),
                          );
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
