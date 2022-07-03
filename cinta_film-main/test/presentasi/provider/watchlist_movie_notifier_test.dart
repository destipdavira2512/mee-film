import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/usecases/ambil_daftar_tonton_film.dart';
import 'package:cinta_film/presentasi/provider/watchlist_movie_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([ClassDaftarTontonFilm])
void main() {
  late NotifikasiDaftarTontonFilm provider;
  late MockClassDaftarTontonFilm mockClassDaftarTontonFilm;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockClassDaftarTontonFilm = MockClassDaftarTontonFilm();
    provider = NotifikasiDaftarTontonFilm(
      ambilDaftarTontonFilm: mockClassDaftarTontonFilm,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change Film data when data is gotten successfully', () async {
    // arrange
    when(mockClassDaftarTontonFilm.execute())
        .thenAnswer((_) async => Right([testwatchlistMovie]));
    // act
    await provider.fetchwatchlistMovies();
    // assert
    expect(provider.watchlistState, RequestState.Loaded);
    expect(provider.watchlistMovies, [testwatchlistMovie]);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockClassDaftarTontonFilm.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchwatchlistMovies();
    // assert
    expect(provider.watchlistState, RequestState.Error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
