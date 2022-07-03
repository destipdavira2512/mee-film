import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/entities/tvls/tvls_detail.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';

class ClassSimpanDaftarTontonTvls {
  final TvlsRepository repository;

  ClassSimpanDaftarTontonTvls(this.repository);

  Future<Either<Failure, String>> execute(TvlsDetail tv) {
    return repository.savewatchlistTv(tv);
  }
}
