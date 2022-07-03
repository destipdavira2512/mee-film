import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';

class SearchTvls {
  final TvlsRepository repository;

  SearchTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute(String query) {
    return repository.searchTv(query);
  }
}
