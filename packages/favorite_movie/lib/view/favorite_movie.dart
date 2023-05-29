import 'package:favorite_movie/bloc/bloc_event.dart';
import 'package:favorite_movie/bloc/bloc_state.dart';
import 'package:favorite_movie/bloc/favorite_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/helper/style.dart';
import 'package:movie/local_storage/local_movie_model.dart';

class FavoriteMovie extends StatefulWidget {
  const FavoriteMovie({Key? key}) : super(key: key);

  @override
  _FavoriteMovieState createState() => _FavoriteMovieState();
}

class _FavoriteMovieState extends State<FavoriteMovie> {
  List<LocalMovieModel> favoriteData = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    context.read<FavoriteMovieBloc>().add(SavedMovieData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1B1E25),
      body:
          BlocBuilder<FavoriteMovieBloc, BlocState>(builder: (context, state) {
        if (state is LoadingMovieData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else if (state is FetchMovieData) {
          print("FetchDataFavorite = ${state.data}");
          favoriteData.clear();
          state.data.forEach((element) {
            favoriteData.add(LocalMovieModel.fromJson(element));
          });

          return Container(
            height: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 60, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Favorite Movie / Tv Series",
                  style: CustomStyle().fontStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: favoriteData
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        height: 80,
                                        width: 76,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          child: e.image == null
                                              ? Center(
                                                  child: Text(
                                                  "No Image",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ))
                                              : Image.network(
                                                  'https://image.tmdb.org/t/p/w500${e.image}',
                                                  fit: BoxFit.cover,
                                                ),
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  1.6,
                                          child: Text(
                                            "${e.name}",
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomStyle()
                                                .fontStyle
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        RatingBar.builder(
                                          itemSize: 20,
                                          initialRating: e.rating == null
                                              ? 0
                                              : e.rating! / 2,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Container(
                                        //   width:
                                        //       MediaQuery.of(context).size.width / 1.6,
                                        //   child: Text(
                                        //     "${Jiffy.parse(e..toString()).yMMMMd},",
                                        //     style: CustomStyle().fontStyle.copyWith(
                                        //         color: Color(0xff696D74),
                                        //         fontSize: 15,
                                        //         fontWeight: FontWeight.bold),
                                        //   ),
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ErrorFetchData) {
          return Text("Error Data");
        }

        return Container();
      }),
    );
  }
}
