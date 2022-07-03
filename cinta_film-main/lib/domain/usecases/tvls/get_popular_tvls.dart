import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';

class GetPopularTvls {
  final TvlsRepository repository;

  GetPopularTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getPopularTv();
  }
}
