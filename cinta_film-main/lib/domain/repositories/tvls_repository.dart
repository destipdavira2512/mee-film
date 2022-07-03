import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls_detail.dart';
import 'package:cinta_film/common/failure.dart';

abstract class TvlsRepository {
  Future<Either<Failure, List<Tvls>>> getserialTvSaatIniDiPutar();
  Future<Either<Failure, List<Tvls>>> getPopularTv();
  Future<Either<Failure, List<Tvls>>> getTopRatedTv();
  Future<Either<Failure, TvlsDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tvls>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tvls>>> searchTv(String query);
  Future<Either<Failure, String>> savewatchlistTv(TvlsDetail tv);
  Future<Either<Failure, String>> removewatchlistTv(TvlsDetail tv);
  Future<bool> isAddedTowatchlistTv(int id);
  Future<Either<Failure, List<Tvls>>> getwatchlistTv();
}
