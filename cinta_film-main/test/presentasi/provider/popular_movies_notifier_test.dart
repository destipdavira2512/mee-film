import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/film.dart';
// import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler_test.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:cinta_film/presentasi/provider/get_data_film_terpopuler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_notifier_test.mocks.dart';

@GenerateMocks([ClassFilmTerPopuler])
void main() {
  late MockClassFilmTerPopuler mockClassFilmTerPopuler;
  late NotifikasiFilmTerPopuler notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockClassFilmTerPopuler = MockClassFilmTerPopuler();
    notifier = NotifikasiFilmTerPopuler(mockClassFilmTerPopuler)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = Film(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Film>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockClassFilmTerPopuler.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.ambilDataFilmTerPopuler();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change Film data when data is gotten successfully', () async {
    // arrange
    when(mockClassFilmTerPopuler.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.ambilDataFilmTerPopuler();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.film, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockClassFilmTerPopuler.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.ambilDataFilmTerPopuler();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
