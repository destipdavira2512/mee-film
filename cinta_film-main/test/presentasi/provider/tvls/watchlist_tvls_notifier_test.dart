import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:cinta_film/presentasi/provider/tvls/watchlist_tvls_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import 'watchlist_tvls_notifier_test.mocks.dart';

@GenerateMocks([GetwatchlistTvls])
void main() {
  late WatchlistTvlsNotifier provider;
  late MockGetwatchlistTvls mockGetwatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetwatchlistTv = MockGetwatchlistTvls();
    provider = WatchlistTvlsNotifier(
      getwatchlistTv: mockGetwatchlistTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetwatchlistTv.execute())
        .thenAnswer((_) async => Right([testwatchlistTv]));
    // act
    await provider.fetchwatchlistTv();
    // assert
    expect(provider.watchlistTvState, RequestState.Loaded);
    expect(provider.watchlistTv, [testwatchlistTv]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetwatchlistTv.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchwatchlistTv();
    // assert
    expect(provider.watchlistTvState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
