import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_tayang_saat_ini.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:cinta_film/presentasi/provider/movie_list_notifier.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_list_notifier_test.mocks.dart';

@GenerateMocks(
    [ClasFilmTayangSaatIni, ClassFilmTerPopuler, ClassFilmRatingTerbaik])
void main() {
  late MovieListNotifier provider;
  late MockClasFilmTayangSaatIni mockClasFilmTayangSaatIni;
  late MockClassFilmTerPopuler mockClassFilmTerPopuler;
  late MockClassFilmRatingTerbaik mockClassFilmRatingTerbaik;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockClasFilmTayangSaatIni = MockClasFilmTayangSaatIni();
    mockClassFilmTerPopuler = MockClassFilmTerPopuler();
    mockClassFilmRatingTerbaik = MockClassFilmRatingTerbaik();
    provider = MovieListNotifier(
      filmTayangSaatIni: mockClasFilmTayangSaatIni,
      getPopularMovies: mockClassFilmTerPopuler,
      ambilFilmRatingTerbaik: mockClassFilmRatingTerbaik,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('now playing Film', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockClasFilmTayangSaatIni.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      verify(mockClasFilmTayangSaatIni.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockClasFilmTayangSaatIni.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change Film when data is gotten successfully', () async {
      // arrange
      when(mockClasFilmTayangSaatIni.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockClasFilmTayangSaatIni.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingMovies();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular Film', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockClassFilmTerPopuler.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.ambilDataFilmTerPopuler();
      // assert
      expect(provider.popularMoviesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change Film data when data is gotten successfully', () async {
      // arrange
      when(mockClassFilmTerPopuler.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.ambilDataFilmTerPopuler();
      // assert
      expect(provider.popularMoviesState, RequestState.Loaded);
      expect(provider.popularMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockClassFilmTerPopuler.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.ambilDataFilmTerPopuler();
      // assert
      expect(provider.popularMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated Film', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockClassFilmRatingTerbaik.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loading);
    });

    test('should change Film data when data is gotten successfully', () async {
      // arrange
      when(mockClassFilmRatingTerbaik.execute())
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedMoviesState, RequestState.Loaded);
      expect(provider.topRatedMovies, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockClassFilmRatingTerbaik.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedMovies();
      // assert
      expect(provider.topRatedMoviesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
