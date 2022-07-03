import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/tvls/tvls_detail.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';
import 'package:cinta_film/common/failure.dart';

class GetTvlsDetail {
  final TvlsRepository repository;

  GetTvlsDetail(this.repository);

  Future<Either<Failure, TvlsDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
