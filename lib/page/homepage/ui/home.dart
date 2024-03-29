import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:movie/di/dependency.dart';
import 'package:movie/helper/style.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/bloc/homepage_bloc.dart';
import 'package:movie/page/homepage/model/popular_tv_series_model.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';
import 'package:movie/page/homepage/ui/movie_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String randomName = "";

  static const platform = MethodChannel('android/channel');

  _generateRandomNumber() async {
    String random;
    try {
      random = await platform.invokeMethod('getName');
      print("random = ${random.toString()}");
      randomName = random;
      setState(() {

      });
    } on PlatformException catch (e) {
      random = "";
    }
  }

  List<ResultUpcomingMovie>? resultUpcomingMovie = [];
  List<TopTvResult> resultTvSeries = [];

  ScrollController? _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1B1E25),
        body: ListView(
          controller: _controller,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.fromLTRB(24, 24, 0, 0),
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.network(
                              'https://www.pngfind.com/pngs/m/292-2924858_user-icon-business-man-flat-png-transparent-png.png',
                              fit: BoxFit.cover,
                            ),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Morning,",
                            style: CustomStyle().fontStyle.copyWith(
                                color: Color(0xff696D74),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            randomName,
                            style: CustomStyle()
                                .fontStyle
                                .copyWith(color: Colors.white, fontSize: 15),
                          )
                        ],
                      )
                    ],
                  ),
                  Icon(
                    Icons.notifications,
                    size: 25,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Movie",
                    style: CustomStyle().fontStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    "See more",
                    style: CustomStyle().fontStyle.copyWith(
                          color: Color(0xff696D74),
                          fontSize: 15,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<TopMovieBloc, BlocState>(listener: (context, state) {
              if (state is BlocLoadingTopMovie) {
                print("Topppp");
              }
            }, builder: (context, state) {
              if (state is BlocLoadingTopMovie) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BlocLoadedTopMovie ||
                  state is BlocLoadingMoreTopMovie) {
                if (state is BlocLoadedTopMovie) {
                  resultUpcomingMovie = state.data;
                  print("reslutLength = ${resultUpcomingMovie!.length}");
                }
                return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Row(
                          children: resultUpcomingMovie!
                              .map((e) => new Padding(
                            padding: const EdgeInsets.only(
                                        right: 16, top: 8, bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MovieDetail(
                                                      resultUpcomingMovie: e,
                                                      dbHelper: locator(),
                                                    )));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 250,
                                            width: 190,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/w500${e.posterPath}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              "${e.title}",
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomStyle()
                                                  .fontStyle
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 20,
                                            initialRating: e.voteAverage! / 2,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        MaterialButton(
                          onPressed: () {
                            context
                                .read<TopMovieBloc>()
                                .add(FetchTopMovieLoadMore());
                          },
                          child: state is BlocLoadingMoreTopMovie
                              ? CircularProgressIndicator()
                              : Text(
                                  "Load More",
                                  style: CustomStyle().fontStyle.copyWith(
                                      color: Colors.white, fontSize: 16),
                                ),
                        )
                      ],
                    ));
              } else if (state is BlocError) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(color: Colors.black87),
                  ),
                );
              }
              return Container(
                child: Center(
                    child: Text(
                  "No Data",
                  style: TextStyle(color: Colors.black87),
                )),
              );
            }),
            SizedBox(
              height: 25,
            ),
            BlocConsumer<TvBloc, BlocState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is BlocLoadingTvSeries) {
                    print("loadinggg");
                    return Container(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is BlocLoadedTvSeries) {
                    resultTvSeries = state.data;
                    print("reslutLengthTvseries = ${resultTvSeries.length}");
                    return Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tv Series",
                                style: CustomStyle().fontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              Text(
                                "See more",
                                style: CustomStyle().fontStyle.copyWith(
                                      color: Color(0xff696D74),
                                      fontSize: 15,
                                    ),
                              )
                            ],
                          ),
                          ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: resultTvSeries.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 80,
                                          width: 76,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                            child: resultTvSeries[index]
                                                        .posterPath ==
                                                    null
                                                ? Center(
                                                    child: Text(
                                                    "No Image",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                                : Image.network(
                                                    'https://image.tmdb.org/t/p/w500${resultTvSeries[index].posterPath}',
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: Text(
                                              "${resultTvSeries[index].name}",
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
                                            initialRating: resultTvSeries[index]
                                                        .voteAverage ==
                                                    null
                                                ? 0
                                                : resultTvSeries[index]
                                                        .voteAverage! /
                                                    2,
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.6,
                                            child: Text(
                                              "${Jiffy.parse(resultTvSeries[index].firstAirDate.toString()).yMMMMd},",
                                              style: CustomStyle()
                                                  .fontStyle
                                                  .copyWith(
                                                      color: Color(0xff696D74),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    );
                  } else if (state is BlocError) {
                    return Text(
                      state.error,
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  return Container();
                }),
          ],
        ));
  }
}