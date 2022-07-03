import 'package:cinta_film/common/exception.dart';
import 'package:cinta_film/data/datasources/db/database_helper.dart';
import 'package:cinta_film/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertwatchlist(MovieTable film);
  Future<String> removewatchlist(MovieTable film);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> ambilDaftarTontonFilm();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertwatchlist(MovieTable film) async {
    try {
      await databaseHelper.insertwatchlist(film);
      return 'Added to watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removewatchlist(MovieTable film) async {
    try {
      await databaseHelper.removewatchlist(film);
      return 'Removed from watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> ambilDaftarTontonFilm() async {
    final result = await databaseHelper.ambilDaftarTontonFilm();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
