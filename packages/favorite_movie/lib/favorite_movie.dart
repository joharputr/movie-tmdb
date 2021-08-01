import 'package:flutter/material.dart';

class FavoriteMovie extends StatefulWidget {
  const FavoriteMovie({Key? key}) : super(key: key);

  @override
  _FavoriteMovieState createState() => _FavoriteMovieState();
}

class _FavoriteMovieState extends State<FavoriteMovie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.red,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
