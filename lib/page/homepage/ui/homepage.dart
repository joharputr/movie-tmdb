import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/page/homepage/bloc/bloc_event.dart';
import 'package:movie/page/homepage/bloc/bloc_state.dart';
import 'package:movie/page/homepage/bloc/homepage_bloc.dart';
import 'package:movie/page/homepage/model/upcomming_movie_model.dart';
import 'package:movie/page/homepage/ui/home.dart';
import 'package:search/search_movie.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    context.read<TopMovieBloc>().add(FetchTopMovie());

    context.read<TvBloc>().add(FetchPopularTvSeries());

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    SearchMovie(),
    Text(
      'Index 2: School',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xff1D2027),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color(0xff1D2027),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.blue,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/icon_home.svg",
                    color: Colors.white,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/svg/icon_home.svg",
                    color: Colors.blueAccent,
                    height: 25,
                    width: 25,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/icon_search.svg",
                    color: Colors.white,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/svg/icon_search.svg",
                    color: Colors.blueAccent,
                    height: 27,
                    width: 27,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/svg/icon_save.svg",
                    color: Colors.white,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/svg/icon_save.svg",
                    color: Colors.blueAccent,
                    height: 27,
                    width: 27,
                  ),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            body: _widgetOptions.elementAt(_selectedIndex)));
  }
}
