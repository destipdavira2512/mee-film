import 'package:cinta_film/domain/repositories/tvls_repository.dart';

class ClassStatusDaftarTontonTvls {
  final TvlsRepository repository;

  ClassStatusDaftarTontonTvls(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedTowatchlistTv(id);
  }
}
