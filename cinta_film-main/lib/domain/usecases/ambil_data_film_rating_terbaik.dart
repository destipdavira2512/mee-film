import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';

class ClassFilmRatingTerbaik {
  final RepositoryFilm repository;

  ClassFilmRatingTerbaik(this.repository);

  Future<Either<Failure, List<Film>>> execute() {
    return repository.ambilFilmRatingTerbaik();
  }
}
