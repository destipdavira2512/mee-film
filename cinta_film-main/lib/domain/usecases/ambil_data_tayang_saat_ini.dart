import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:cinta_film/common/failure.dart';

class ClasFilmTayangSaatIni {
  final RepositoryFilm repository;

  ClasFilmTayangSaatIni(this.repository);

  Future<Either<Failure, List<Film>>> execute() {
    return repository.filmTayangSaatIni();
  }
}
