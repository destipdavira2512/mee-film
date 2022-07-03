import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:flutter/material.dart';

class TvlsListNotifier extends ChangeNotifier {
  var _serialTvRatingTerbaik = <Tvls>[];
  List<Tvls> get serialTvRatingTerbaik => _serialTvRatingTerbaik;

  RequestState _serialTvRatingTerbaikState = RequestState.Empty;
  RequestState get serialTvRatingTerbaikState => _serialTvRatingTerbaikState;

  var _serialTvSaatIniDiPutar = <Tvls>[];
  List<Tvls> get serialTvSaatIniDiPutar => _serialTvSaatIniDiPutar;

  RequestState _serialTvSaatIniDiPutarState = RequestState.Empty;
  RequestState get serialTvSaatIniDiPutarState => _serialTvSaatIniDiPutarState;

  var _popularTv = <Tvls>[];
  List<Tvls> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  String _message = '';
  String get message => _message;

  TvlsListNotifier({
    required this.getserialTvSaatIniDiPutarls,
    required this.getPopularTvls,
    required this.getTopRatedTvls,
  });

  final GetserialTvSaatIniDiPutarls getserialTvSaatIniDiPutarls;
  final GetPopularTvls getPopularTvls;
  final GetTopRatedTvls getTopRatedTvls;

  Future<void> fetchserialTvSaatIniDiPutar() async {
    _serialTvSaatIniDiPutarState = RequestState.Loading;
    notifyListeners();

    final result = await getserialTvSaatIniDiPutarls.execute();
    result.fold(
      (failure) {
        _serialTvSaatIniDiPutarState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _serialTvSaatIniDiPutarState = RequestState.Loaded;
        _serialTvSaatIniDiPutar = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvls.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _serialTvRatingTerbaikState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvls.execute();
    result.fold(
      (failure) {
        _serialTvRatingTerbaikState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _serialTvRatingTerbaikState = RequestState.Loaded;
        _serialTvRatingTerbaik = tvData;
        notifyListeners();
      },
    );
  }
}
