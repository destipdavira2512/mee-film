import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:cinta_film/common/failure.dart';

class GetMovieDetail {
  final RepositoryFilm repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
