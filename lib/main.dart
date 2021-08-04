import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/page/homepage/bloc/detail_movie_bloc.dart';
import 'package:movie/page/homepage/bloc/homepage_bloc.dart';
import 'package:movie/page/homepage/ui/homepage.dart';

import 'package:favorite_movie/bloc/favorite_movie_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TopMovieBloc>(create: (_) => TopMovieBloc()),
      BlocProvider<FavoriteMovieBloc>(create: (_) => FavoriteMovieBloc()),
      BlocProvider(create: (_) => DetailMovieBloc()),
      BlocProvider<TvBloc>(create: (_) => TvBloc()),
    ], child: Homepage());
    // return MaterialApp(routes: {
    //   '/': (context) {
    //     return Homepage();
    //   }
    // });
  }
}
