import 'package:flutter/material.dart';
import 'package:movie/helper/style.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({Key? key}) : super(key: key);

  @override
  _SearchMovieState createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color(0xff1B1E25),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))),
        height: double.infinity,
        child: ListView(
          padding: EdgeInsets.all(24),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.white),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 0, right: 15),
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
                    ))
          ],
        ));
  }
}
