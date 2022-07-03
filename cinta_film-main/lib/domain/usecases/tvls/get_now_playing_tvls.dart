import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';
import 'package:cinta_film/common/failure.dart';

class GetserialTvSaatIniDiPutarls {
  final TvlsRepository repository;

  GetserialTvSaatIniDiPutarls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getserialTvSaatIniDiPutar();
  }
}
