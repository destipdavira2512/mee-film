import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from watchlist';

  final GetMovieDetail getMovieDetail;
  final AmbilDataRekomendasiFilm getMovieRecommendations;
  final ClassStatusDaftarTonton getwatchlistStatus;
  final ClassSimpanDaftarTonton savewatchlist;
  final ClassHapusDaftarTonton removewatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getwatchlistStatus,
    required this.savewatchlist,
    required this.removewatchlist,
  });

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  late MovieDetail _movie;
  MovieDetail get film => _movie;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  List<Film> _movieRecommendations = [];
  List<Film> get movieRecommendations => _movieRecommendations;

  bool _isAddedtowatchlist = false;
  bool get isAddedTowatchlist => _isAddedtowatchlist;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (film) {
        _recommendationState = RequestState.Loading;
        _movie = film;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (film) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = film;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> tambahDaftarTonton(MovieDetail film) async {
    final result = await savewatchlist.execute(film);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadwatchlistStatus(film.id);
  }

  Future<void> removeFromwatchlist(MovieDetail film) async {
    final result = await removewatchlist.execute(film);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadwatchlistStatus(film.id);
  }

  Future<void> loadwatchlistStatus(int id) async {
    final result = await getwatchlistStatus.execute(id);
    _isAddedtowatchlist = result;
    notifyListeners();
  }
}
