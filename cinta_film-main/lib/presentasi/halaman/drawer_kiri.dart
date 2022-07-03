import 'package:cinta_film/presentasi/halaman/halaman_beranda_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_beranda_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_tv_ditonton.dart';
import 'package:cinta_film/presentasi/halaman/halaman_tentang_kami.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_ditonton.dart';
import 'package:flutter/material.dart';

class ClassDrawerKiri {
  Widget darwer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/avatarUserLogIn.png'),
            ),
            accountName: Text('Desti Putri'),
            accountEmail: Text('cintaFilm@dicoding.com'),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Film'),
            onTap: () {
              Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Serial Televisi'),
            onTap: () {
              Navigator.pushNamed(context, HomeTvlsPage.ROUTE_NAME);
            },
          ),
          ExpansionTile(
            title: Text('Daftar Tonton'),
            leading: Icon(Icons.save_alt),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.movie),
                title: Text('film'),
                onTap: () {
                  Navigator.pushNamed(
                      context, ClassHalamanDaftarTontonFilm.ROUTE_NAME);
                },
              ),
              ListTile(
                leading: Icon(Icons.tv),
                title: Text('Televisi'),
                onTap: () {
                  Navigator.pushNamed(
                      context, ClassHalamanListSerialTv.ROUTE_NAME);
                },
              ),
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
            },
            leading: Icon(Icons.info_outline),
            title: Text('Tentang Kami'),
          ),
        ],
      ),
    );
  }
}
