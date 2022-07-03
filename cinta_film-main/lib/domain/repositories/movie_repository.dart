import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/common/failure.dart';

abstract class RepositoryFilm {
  Future<Either<Failure, List<Film>>> filmTayangSaatIni();
  Future<Either<Failure, List<Film>>> ambilDataFilmTerPopuler();
  Future<Either<Failure, List<Film>>> ambilFilmRatingTerbaik();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Film>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Film>>> cariFilm(String query);
  Future<Either<Failure, String>> daftarTonton(MovieDetail film);
  Future<Either<Failure, String>> removewatchlist(MovieDetail film);
  Future<bool> isAddedTowatchlist(int id);
  Future<Either<Failure, List<Film>>> ambilDaftarTontonFilm();
}
