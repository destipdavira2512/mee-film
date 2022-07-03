import 'package:cinta_film/common/exception.dart';
import 'package:cinta_film/data/datasources/db/database_helper_tvls.dart';
import 'package:cinta_film/data/models/tvls/tvls_table.dart';

abstract class TvlsLocalDataSource {
  Future<String> insertwatchlistTv(TvlsTable tv);
  Future<String> removewatchlistTv(TvlsTable tv);
  Future<TvlsTable?> getTvById(int id);
  Future<List<TvlsTable>> getwatchlistTv();
}

class TvlsLocalDataSourceImpl implements TvlsLocalDataSource {
  final DatabaseHelperTvls databaseHelpertvls;

  TvlsLocalDataSourceImpl({required this.databaseHelpertvls});

  @override
  Future<String> insertwatchlistTv(TvlsTable tv) async {
    try {
      await databaseHelpertvls.insertwatchlistTv(tv);
      return 'Added to watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removewatchlistTv(TvlsTable tv) async {
    try {
      await databaseHelpertvls.removewatchlistTv(tv);
      return 'Removed from watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvlsTable?> getTvById(int id) async {
    final result = await databaseHelpertvls.getTvById(id);
    if (result != null) {
      return TvlsTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvlsTable>> getwatchlistTv() async {
    final result = await databaseHelpertvls.getwatchlistTv();
    return result.map((data) => TvlsTable.fromMap(data)).toList();
  }
}
