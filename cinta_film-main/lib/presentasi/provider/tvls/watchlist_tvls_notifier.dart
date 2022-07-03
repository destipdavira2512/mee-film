import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvlsNotifier extends ChangeNotifier {
  String _message = '';
  String get message => _message;

  var _watchlistTv = <Tvls>[];
  List<Tvls> get watchlistTv => _watchlistTv;

  var _watchlistTvState = RequestState.Empty;
  RequestState get watchlistTvState => _watchlistTvState;

  WatchlistTvlsNotifier({required this.getwatchlistTv});

  final GetwatchlistTvls getwatchlistTv;

  Future<void> fetchwatchlistTv() async {
    _watchlistTvState = RequestState.Loading;
    notifyListeners();

    final result = await getwatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistTvState = RequestState.Loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
