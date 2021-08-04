import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/helper/style.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/local_storage/local_movie_model.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/bloc/detail_movie_bloc.dart';
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
                              _helper
                                  .delete(DbHelper.TABLE_NAME, tempData?.id)
                                  .then((value) {
                                favData.removeWhere(
                                    (element) => element.id == tempData?.id);
                                print("deletee = $value");
                              });
                            } else {
                              print("not fav to fav");
                              _helper.insert(
                                DbHelper.TABLE_NAME,
                                localMovieModel.toMap(
                                    id: tempData?.id,
                                    rating:
                                        ((tempData!.voteAverage)! ~/ 2).toInt(),
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
                  ],
                ),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
