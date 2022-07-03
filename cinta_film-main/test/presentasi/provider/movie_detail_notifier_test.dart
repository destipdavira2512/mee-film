import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:cinta_film/presentasi/provider/movie_detail_notifier.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  AmbilDataRekomendasiFilm,
  ClassStatusDaftarTonton,
  ClassSimpanDaftarTonton,
  ClassHapusDaftarTonton,
])
void main() {
  late MovieDetailNotifier provider;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockAmbilDataRekomendasiFilm mockAmbilDataRekomendasiFilm;
  late MockClassStatusDaftarTonton mockClassStatusDaftarTonton;
  late MockClassSimpanDaftarTonton mockClassSimpanDaftarTonton;
  late MockClassHapusDaftarTonton mockClassHapusDaftarTonton;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetMovieDetail = MockGetMovieDetail();
    mockAmbilDataRekomendasiFilm = MockAmbilDataRekomendasiFilm();
    mockClassStatusDaftarTonton = MockClassStatusDaftarTonton();
    mockClassSimpanDaftarTonton = MockClassSimpanDaftarTonton();
    mockClassHapusDaftarTonton = MockClassHapusDaftarTonton();
    provider = MovieDetailNotifier(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockAmbilDataRekomendasiFilm,
      getwatchlistStatus: mockClassStatusDaftarTonton,
      savewatchlist: mockClassSimpanDaftarTonton,
      removewatchlist: mockClassHapusDaftarTonton,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

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
  final tMovies = <Film>[tMovie];

  void _arrangeUsecase() {
    when(mockGetMovieDetail.execute(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    when(mockAmbilDataRekomendasiFilm.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Get film Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      verify(mockGetMovieDetail.execute(tId));
      verify(mockAmbilDataRekomendasiFilm.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change film when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.film, testMovieDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation Film when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovies);
    });
  });

  group('Get film Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      verify(mockAmbilDataRekomendasiFilm.execute(tId));
      expect(provider.movieRecommendations, tMovies);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.movieRecommendations, tMovies);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockAmbilDataRekomendasiFilm.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Daftar Tonton', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockClassStatusDaftarTonton.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadwatchlistStatus(1);
      // assert
      expect(provider.isAddedTowatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockClassSimpanDaftarTonton.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockClassStatusDaftarTonton.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.tambahDaftarTonton(testMovieDetail);
      // assert
      verify(mockClassSimpanDaftarTonton.execute(testMovieDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockClassHapusDaftarTonton.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockClassStatusDaftarTonton.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromwatchlist(testMovieDetail);
      // assert
      verify(mockClassHapusDaftarTonton.execute(testMovieDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockClassSimpanDaftarTonton.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));
      when(mockClassStatusDaftarTonton.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.tambahDaftarTonton(testMovieDetail);
      // assert
      verify(mockClassStatusDaftarTonton.execute(testMovieDetail.id));
      expect(provider.isAddedTowatchlist, true);
      expect(provider.watchlistMessage, 'Added to watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockClassSimpanDaftarTonton.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockClassStatusDaftarTonton.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.tambahDaftarTonton(testMovieDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockAmbilDataRekomendasiFilm.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      // act
      await provider.fetchMovieDetail(tId);
      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
