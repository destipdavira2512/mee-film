import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinta_film/presentasi/halaman/drawer_kiri.dart';
import 'package:cinta_film/common/constants.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_rating_terbaik.dart';
import 'package:cinta_film/presentasi/provider/movie_list_notifier.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
  static const ROUTE_NAME = '/home';
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MovieListNotifier>(context, listen: false)
          ..fetchNowPlayingMovies()
          ..ambilDataFilmTerPopuler()
          ..fetchTopRatedMovies());
  }

  final drawerFrame = ClassDrawerKiri();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerFrame.darwer(context),
      appBar: AppBar(
        title: Text('Cinta Film'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Film Saat Ini Tayang',
                textAlign: TextAlign.center,
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                switch (state) {
                  case RequestState.Loading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case RequestState.Loaded:
                    return MovieList(data.nowPlayingMovies);
                  default:
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 45,
                              color: Colors.deepOrangeAccent,
                            ),
                            Text(
                                ' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                          ],
                        ),
                      ),
                    );
                }
              }),
              _buildSubHeading(
                title: 'Film Terpopuler',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.popularMovies);
                } else {
                  return Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 45,
                            color: Colors.deepOrangeAccent,
                          ),
                          Text(
                              ' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                        ],
                      ),
                    ),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Film Dengan Rating Terbaik',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.topRatedMovies);
                } else {
                  return Center(
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 45,
                            color: Colors.deepOrangeAccent,
                          ),
                          Text(
                              ' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                        ],
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('Lebih Banyak'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Film> film;

  MovieList(this.film);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final filmList = film[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: filmList.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${filmList.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: film.length,
      ),
    );
  }
}
