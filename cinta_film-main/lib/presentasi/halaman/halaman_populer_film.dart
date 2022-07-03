import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/presentasi/provider/get_data_film_terpopuler.dart';
import 'package:cinta_film/presentasi/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-film';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NotifikasiFilmTerPopuler>(context, listen: false)
            .ambilDataFilmTerPopuler());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotifikasiFilmTerPopuler>(
          builder: (context, data, child) {
            switch (data.state) {
              case RequestState.Loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.Loaded:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final film = data.film[index];
                    return MovieCard(film);
                  },
                  itemCount: data.film.length,
                );
              default:
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
            }
          },
        ),
      ),
    );
  }
}
