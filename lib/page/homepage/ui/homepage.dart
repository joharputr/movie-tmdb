import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/bloc/homepage_bloc.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Result>? result = [];
  int page = 1;

  @override
  void initState() {
    context.read<TopMovieBloc>().add(FetchTopMovie(page: page));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xff1D2027),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(24),
          children: [
            Row(
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
                            'https://mmc.tirto.id/image/otf/700x0/2019/04/25/avengers-endgame-marvel-studios_ratio-16x9.jpg',
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
                          style: TextStyle(
                              color: Color(0xff696D74),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Avenger",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
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
            SizedBox(
              height: 35,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Movie",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Text(
                  "See more",
                  style: TextStyle(
                    color: Color(0xff696D74),
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<TopMovieBloc, BlocState>(
              builder: (context, state) {
                if (state is BlocLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BlocLoaded || state is BlocLoadingMore) {
                  if (state is BlocLoaded) {
                    print("loadeeeed");
                    UpCommingMovie event = state.data as UpCommingMovie;
                    result!.addAll(event.results!);

                    print("reslutLength = ${result!.length}");
                  }

                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Row(
                            children: result!
                                .map((e) => new Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                                'https://mmc.tirto.id/image/otf/700x0/2019/04/25/avengers-endgame-marvel-studios_ratio-16x9.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "${e.title}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          RatingBar.builder(
                                            itemSize: 20,
                                            initialRating: 3,
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
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                page++;
                              });
                              context
                                  .read<TopMovieBloc>()
                                  .add(FetchTopMovieLoadMore(page: page));
                            },
                            child: state is BlocLoadingMore
                                ? CircularProgressIndicator()
                                : Text(
                                    "Load More",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                          )
                        ],
                      ));
                } else if (state is BlocError) {
                  return Text(
                    state.error,
                    style: TextStyle(color: Colors.white),
                  );
                }
                return Container();
              },
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tv Series",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Text(
                  "See more",
                  style: TextStyle(
                    color: Color(0xff696D74),
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 80,
                            width: 76,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image.network(
                                'https://mmc.tirto.id/image/otf/700x0/2019/04/25/avengers-endgame-marvel-studios_ratio-16x9.jpg',
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Drama,",
                              style: TextStyle(
                                  color: Color(0xff696D74),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Avenger your Hero",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
