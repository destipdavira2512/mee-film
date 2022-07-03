import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:cinta_film/common/failure.dart';

class ClassDaftarTontonFilm {
  final RepositoryFilm _repository;

  ClassDaftarTontonFilm(this._repository);

  Future<Either<Failure, List<Film>>> execute() {
    return _repository.ambilDaftarTontonFilm();
  }
}
