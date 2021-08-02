import 'package:favorite_movie/bloc/bloc_event.dart';
import 'package:favorite_movie/bloc/bloc_state.dart';
import 'package:favorite_movie/bloc/favorite_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/local_storage/db_helper.dart';
import 'package:movie/local_storage/local_movie_model.dart';

class FavoriteMovie extends StatefulWidget {
  const FavoriteMovie({Key? key}) : super(key: key);

  @override
  _FavoriteMovieState createState() => _FavoriteMovieState();
}

class _FavoriteMovieState extends State<FavoriteMovie> {
  List<LocalMovieModel> favoriteData = [];
  DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    context.read<FavoriteMovieBloc>().add(SavedMovieData());
    _dbHelper.getData(DbHelper.TABLE_NAME).then((value) {
      print("sdds");
      value.forEach((element) {
        // print('elementtt = $element');
        //         yield FetchMovieData(data: LocalMovieModel.fromJson(element));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder<FavoriteMovieBloc, BlocState>(
            builder: (context, state) {
          if (state is LoadingMovieData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else if (state is FetchMovieData) {
            print("MasukFetch = ${state.data}");
            state.data.forEach((element) {
              favoriteData.add(LocalMovieModel.fromJson(element));
            });

            return SingleChildScrollView(
              child: Column(
                children: favoriteData
                    .map((e) => Text(
                          "sdsdsds",
                          style: TextStyle(color: Colors.black),
                        ))
                    .toList(),
              ),
            );
          } else if (state is ErrorFetchData) {
            return Text("Error Data");
          }

          return Container();
        }),
      ),
    );
  }
}
