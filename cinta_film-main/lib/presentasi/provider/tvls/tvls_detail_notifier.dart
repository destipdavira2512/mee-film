import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/entities/tvls/tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvlsDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from watchlist';

  final GetTvlsDetail getTvlsDetail;
  final ClassSimpanDaftarTontonTvls savewatchlistTvls;
  final ClassHapusDaftarTontonTvls removewatchlistTvls;
  final ClassStatusDaftarTontonTvls getwatchlistStatusTvls;
  final GetTvlsRecommendations getTvlsRecommendations;

  TvlsDetailNotifier({
    required this.getTvlsDetail,
    required this.getTvlsRecommendations,
    required this.getwatchlistStatusTvls,
    required this.savewatchlistTvls,
    required this.removewatchlistTvls,
  });

  late TvlsDetail _tv;
  TvlsDetail get tv => _tv;

  List<Tvls> _tvRecommendations = [];
  List<Tvls> get tvRecommendations => _tvRecommendations;

  RequestState _recommendationTvState = RequestState.Empty;
  RequestState get recommendationTvState => _recommendationTvState;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  String _message = '';
  String get message => _message;

  bool _isAddedtowatchlistTv = false;
  bool get isAddedTowatchlistTv => _isAddedtowatchlistTv;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvlsDetail.execute(id);
    final recommendationResult = await getTvlsRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationTvState = RequestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationTvState = RequestState.Error;
            _message = failure.message;
          },
          (tv) {
            _recommendationTvState = RequestState.Loaded;
            _tvRecommendations = tv;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessageTv = '';
  String get watchlistMessageTv => _watchlistMessageTv;

  Future<void> addwatchlistTv(TvlsDetail tv) async {
    final result = await savewatchlistTvls.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessageTv = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTv = successMessage;
      },
    );

    await loadwatchlistStatusTv(tv.id);
  }

  Future<void> removeFromwatchlistTv(TvlsDetail tv) async {
    final result = await removewatchlistTvls.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessageTv = failure.message;
      },
      (successMessage) async {
        _watchlistMessageTv = successMessage;
      },
    );

    await loadwatchlistStatusTv(tv.id);
  }

  Future<void> loadwatchlistStatusTv(int id) async {
    final result = await getwatchlistStatusTvls.execute(id);
    _isAddedtowatchlistTv = result;
    notifyListeners();
  }
}
