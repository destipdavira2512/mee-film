import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:flutter/foundation.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final ClassFilmRatingTerbaik ambilFilmRatingTerbaik;

  TopRatedMoviesNotifier({required this.ambilFilmRatingTerbaik});

  List<Film> _movies = [];
  List<Film> get film => _movies;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchTopRatedMovies() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await ambilFilmRatingTerbaik.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
