import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';

class ClassHapusDaftarTonton {
  final RepositoryFilm repository;

  ClassHapusDaftarTonton(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail film) {
    return repository.removewatchlist(film);
  }
}
