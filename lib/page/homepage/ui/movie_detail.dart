import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/helper/style.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/local_storage/local_movie_model.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/bloc/detail_movie_bloc.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class MovieDetail extends StatefulWidget {
  final DbHelper dbHelper;
  final ResultUpcomingMovie? resultUpcomingMovie;

  MovieDetail({required this.dbHelper, this.resultUpcomingMovie});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  LocalMovieModel localMovieModel = LocalMovieModel();
  ResultUpcomingMovie? tempData;
  List<LocalMovieModel> favData = [];
  bool? isFavorite = false;

  @override
  void initState() {
    tempData = this.widget.resultUpcomingMovie;

    context.read<DetailMovieBloc>().add(FetchDetailMovie());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Color(0xff1B1E25),
          elevation: 0,
        ),
        body:
            BlocBuilder<DetailMovieBloc, BlocState>(builder: (context, state) {
          if (state is BLocLoadingDetailMovie) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BlocDetailMovie) {
            //   favData.add(LocalMovieModel.fromJson(state.data));
            List<Map<String, Object?>> data = state.data;
            //   favData.addAll(data);
            data.forEach((element) {
              print("dataSved = $element");
              favData.add(LocalMovieModel.fromJson(element));
            });
            //   favData.addAll(state.data);
            if (favData.contains(LocalMovieModel.fromJson(localMovieModel.toMap(
                id: tempData?.id,
                rating: ((tempData!.voteAverage)! ~/ 2).toInt(),
                name: tempData?.title,
                image: 'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
                overview: tempData?.overview)))) {
              print("trueee");
              isFavorite = true;
            } else {
              isFavorite = false;
              print('falseee');
            }
            return Container(
              color: Color(0xff1B1E25),
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
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
                          color: isFavorite! ? Colors.red : Colors.white,
                        ),
                        onTap: () {
                          if (isFavorite!) {
                            print("fav to not fav");
                            this
                                .widget
                                .dbHelper
                                .delete(DbHelper.TABLE_NAME, tempData?.id)
                                .then((value) {
                              favData.removeWhere(
                                  (element) => element.id == tempData?.id);
                              print("deletee = $value");
                            });
                          } else {
                            print("not fav to fav");
                            this.widget.dbHelper.insert(
                                  DbHelper.TABLE_NAME,
                                  localMovieModel.toMap(
                                      id: tempData?.id,
                                      rating: ((tempData!.voteAverage)! ~/ 2)
                                          .toInt(),
                                      name: tempData?.title,
                                      image:
                                          'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
                                      overview: tempData?.overview),
                                );
                          }
                          context
                              .read<DetailMovieBloc>()
                              .add(FetchDetailMovie());
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.15,
                              height: MediaQuery.of(context).size.height / 1.8,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${tempData?.posterPath}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "${tempData?.title}",
                            overflow: TextOverflow.ellipsis,
                            style: CustomStyle()
                                .fontStyle
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            itemSize: 20,
                            initialRating: tempData!.voteAverage! / 2,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${tempData?.overview}',
                            textAlign: TextAlign.justify,
                            style: CustomStyle()
                                .fontStyle
                                .copyWith(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
