import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvlsNotifier extends ChangeNotifier {
  final GetTopRatedTvls getTopRatedTv;

  TopRatedTvlsNotifier({required this.getTopRatedTv});

  List<Tvls> _tv = [];
  List<Tvls> get tv => _tv;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
