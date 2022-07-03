import 'dart:io';
import 'package:cinta_film/common/utils.dart';
import 'package:cinta_film/presentasi/halaman/halaman_tentang_kami.dart';
import 'package:cinta_film/presentasi/halaman/nav_bar_bawah.dart';
import 'package:cinta_film/presentasi/halaman/halaman_beranda_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_beranda_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_ditonton.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_tv_ditonton.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_rating_terbaik.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_tv_rating_terbaik.dart';
import 'package:cinta_film/presentasi/provider/tvls/watchlist_tvls_notifier.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_tv.dart';
import 'package:cinta_film/presentasi/provider/movie_detail_notifier.dart';
import 'package:cinta_film/presentasi/provider/movie_list_notifier.dart';
import 'package:cinta_film/presentasi/provider/movie_search_notifier.dart';
import 'package:cinta_film/presentasi/provider/get_data_film_terpopuler.dart';
import 'package:cinta_film/presentasi/provider/frame_pesan_film_terpopuler.dart';
import 'package:cinta_film/presentasi/provider/watchlist_movie_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/popular_tvls_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/top_rated_tvls_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_detail_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_list_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_search_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinta_film/injection.dart' as inject;

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  inject.init();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => inject.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<NotifikasiFilmTerPopuler>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<NotifikasiDaftarTontonFilm>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<TvlsListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<TvlsDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<TvlsSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<TopRatedTvlsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<PopularTvlsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => inject.locator<WatchlistTvlsNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Cinta Film',
        theme: ThemeData.fallback(),
        home: BottomBar(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTvlsPage());
            case PopularTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvlsPage());
            case HalamanSerialTvTerbaik.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => HalamanSerialTvTerbaik());
            case TvlsDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvlsDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvlsPage());
            case ClassHalamanDaftarTontonFilm.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => ClassHalamanDaftarTontonFilm());
            case ClassHalamanListSerialTv.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => ClassHalamanListSerialTv());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
