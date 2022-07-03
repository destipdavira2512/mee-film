import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_daftar_tonton_film.dart';
import 'package:flutter/foundation.dart';

class NotifikasiDaftarTontonFilm extends ChangeNotifier {
  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  var _watchlistMovies = <Film>[];
  List<Film> get watchlistMovies => _watchlistMovies;

  NotifikasiDaftarTontonFilm({required this.ambilDaftarTontonFilm});

  final ClassDaftarTontonFilm ambilDaftarTontonFilm;

  Future<void> fetchwatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await ambilDaftarTontonFilm.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
