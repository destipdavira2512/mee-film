import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/search_tvls.dart';
import 'package:flutter/foundation.dart';

class TvlsSearchNotifier extends ChangeNotifier {
  final SearchTvls searchTv;

  TvlsSearchNotifier({required this.searchTv});

  List<Tvls> _searchTvResult = [];
  List<Tvls> get searchTvResult => _searchTvResult;

  String _message = '';
  String get message => _message;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  Future<void> cariSerialTv(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchTvResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
