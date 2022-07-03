import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';

class ClassSimpanDaftarTonton {
  final RepositoryFilm repository;

  ClassSimpanDaftarTonton(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail film) {
    return repository.daftarTonton(film);
  }
}
