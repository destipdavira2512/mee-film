import 'package:cinta_film/presentasi/halaman/halaman_beranda_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_beranda_tv.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeMoviePage(),
    HomeTvlsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            selectedItemColor: Color.fromARGB(255, 31, 31, 31),
            unselectedItemColor: Color.fromARGB(179, 91, 91, 91),
            iconSize: 18,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_roll_rounded),
                label: 'Film',
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie_sharp),
                label: 'Serial Televisi',
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ]));
  }
}
