import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/di/dependency.dart';
import 'package:movie/helper/style.dart';
import 'package:movie/page/homepage/model/popular_tv_series_model.dart';
import 'package:search/bloc/bloc_event.dart';
import 'package:search/bloc/bloc_state.dart';
import 'package:search/bloc/search_bloc.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  List<TopTvResult>? resultSearch = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SearchBloc(api: locator()),
        child: BlocBuilder<SearchBloc, BlocState>(
          builder: (context, state) {
            if (state is LoadingSearchData) {
              return Container(
                  padding: EdgeInsets.fromLTRB(12, 32, 12, 12),
                  decoration: BoxDecoration(
                      color: Color(0xff1B1E25),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  height: double.infinity,
                  child: Builder(builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.white),
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                context
                                    .read<SearchBloc>()
                                    .add(SearchBlocEvent(text: value));

                                print("cekvalue, ${value}");
                              },
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 0, right: 15),
                                  filled: true,
                                  fillColor: Color(0xff282A3E),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2027),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2027),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text("Search Result",
                            style: CustomStyle().fontStyle.copyWith(
                                  fontSize: 20,
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.8,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7,
                                            child: Text(
                                              "The Dark II",
                                              //   overflow: TextOverflow.ellipsis,
                                              style: CustomStyle()
                                                  .fontStyle
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Text(
                                              "7 Januari 2020",
                                              style: CustomStyle()
                                                  .fontStyle
                                                  .copyWith(
                                                      color: Color(0xff696D74),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          RatingBar.builder(
                                            itemSize: 20,
                                            initialRating: 2,
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
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  }));
            } else if (state is SearchData) {
              resultSearch = state.data;
              return Container(
                  padding: EdgeInsets.fromLTRB(12, 32, 12, 12),
                  decoration: BoxDecoration(
                      color: Color(0xff1B1E25),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24))),
                  height: double.infinity,
                  child: Builder(builder: (context) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: Theme(
                            data: Theme.of(context)
                                .copyWith(splashColor: Colors.white),
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                context
                                    .read<SearchBloc>()
                                    .add(SearchBlocEvent(text: value));

                                print("cekvalue, ${value}");
                              },
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(bottom: 0, right: 15),
                                  filled: true,
                                  fillColor: Color(0xff282A3E),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2027),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide(
                                      color: Color(0xff1D2027),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text("Search Result (3)",
                            style: CustomStyle().fontStyle.copyWith(
                                  fontSize: 20,
                                )),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                              addAutomaticKeepAlives: true,
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: 20,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.8,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.network(
                                              'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.7,
                                            child: Text(
                                              "${resultSearch?[0].overview}",
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomStyle()
                                                  .fontStyle
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Text(
                                              "7 Januari 2020",
                                              style: CustomStyle()
                                                  .fontStyle
                                                  .copyWith(
                                                      color: Color(0xff696D74),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          RatingBar.builder(
                                            itemSize: 20,
                                            initialRating: 2,
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
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  }));
            }

            return Container();
          },
        ),
      ),
    );
  }
}
