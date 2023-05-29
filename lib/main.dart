import 'package:favorite_movie/bloc/favorite_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/di/dependency.dart';
import 'package:movie/page/homepage/bloc/detail_movie_bloc.dart';
import 'package:movie/page/homepage/bloc/homepage_bloc.dart';
import 'package:movie/page/homepage/ui/homepage.dart';


void main() {
  Dependency dependency = Dependency();
  dependency.init();
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
      BlocProvider<TopMovieBloc>(create: (_) => TopMovieBloc(api: locator())),
      BlocProvider<FavoriteMovieBloc>(
          create: (_) => FavoriteMovieBloc(dbHelper: locator())),
      BlocProvider(create: (_) => DetailMovieBloc(dbHelper: locator())),
      BlocProvider<TvBloc>(create: (_) => TvBloc(api: locator())),
    ], child: Homepage());
    // return MaterialApp(routes: {
    //   '/': (context) {
    //     return Homepage();
    //   }
    // });
  }
}
