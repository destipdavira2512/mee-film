import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/common/utils.dart';
import 'package:cinta_film/presentasi/provider/watchlist_movie_notifier.dart';
import 'package:cinta_film/presentasi/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassHalamanDaftarTontonFilm extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-film';

  @override
  _ClassHalamanDaftarTontonFilmState createState() =>
      _ClassHalamanDaftarTontonFilmState();
}

class _ClassHalamanDaftarTontonFilmState
    extends State<ClassHalamanDaftarTontonFilm> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NotifikasiDaftarTontonFilm>(context, listen: false)
            .fetchwatchlistMovies());
  }

  void didPopNext() {
    Provider.of<NotifikasiDaftarTontonFilm>(context, listen: false)
        .fetchwatchlistMovies();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tonton'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotifikasiDaftarTontonFilm>(
          builder: (context, data, child) {
            switch (data.watchlistState) {
              case RequestState.Loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.Loaded:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final film = data.watchlistMovies[index];
                    return MovieCard(film);
                  },
                  itemCount: data.watchlistMovies.length,
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
