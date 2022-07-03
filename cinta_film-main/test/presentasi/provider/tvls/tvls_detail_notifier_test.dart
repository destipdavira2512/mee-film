import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import 'tvls_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvlsDetail,
  GetTvlsRecommendations,
  ClassStatusDaftarTontonTvls,
  ClassSimpanDaftarTontonTvls,
  ClassHapusDaftarTontonTvls,
])
void main() {
  late TvlsDetailNotifier provider;
  late MockGetTvlsDetail mockGetTvDetail;
  late MockGetTvlsRecommendations mockGetTvRecommendations;
  late MockClassStatusDaftarTontonTvls mockClassStatusDaftarTonton;
  late MockClassSimpanDaftarTontonTvls mockClassSimpanDaftarTonton;
  late MockClassHapusDaftarTontonTvls mockClassHapusDaftarTonton;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvlsDetail();
    mockGetTvRecommendations = MockGetTvlsRecommendations();
    mockClassStatusDaftarTonton = MockClassStatusDaftarTontonTvls();
    mockClassSimpanDaftarTonton = MockClassSimpanDaftarTontonTvls();
    mockClassHapusDaftarTonton = MockClassHapusDaftarTontonTvls();
    provider = TvlsDetailNotifier(
      getTvlsDetail: mockGetTvDetail,
      getTvlsRecommendations: mockGetTvRecommendations,
      getwatchlistStatusTvls: mockClassStatusDaftarTonton,
      savewatchlistTvls: mockClassSimpanDaftarTonton,
      removewatchlistTvls: mockClassHapusDaftarTonton,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTv = Tvls(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvs = <Tvls>[tTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvs));
  }

  group('Get Tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvs);
    });
  });

  group('Get Tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvRecommendations.execute(tId));
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationTvState, RequestState.Loaded);
      expect(provider.tvRecommendations, tTvs);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvRecommendations.execute(tId)).thenAnswer((_) async =>
          Left(ServerFailure('Upss... Maaf Kami Gagal Memuat Data :(')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.recommendationTvState, RequestState.Error);
      expect(provider.message, 'Upss... Maaf Kami Gagal Memuat Data :(');
    });
  });

  group('Daftar Tonton', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockClassStatusDaftarTonton.execute(1))
          .thenAnswer((_) async => true);
      // act
      await provider.loadwatchlistStatusTv(1);
      // assert
      expect(provider.isAddedTowatchlistTv, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockClassSimpanDaftarTonton.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockClassStatusDaftarTonton.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addwatchlistTv(testTvDetail);
      // assert
      verify(mockClassSimpanDaftarTonton.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockClassHapusDaftarTonton.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockClassStatusDaftarTonton.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromwatchlistTv(testTvDetail);
      // assert
      verify(mockClassHapusDaftarTonton.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockClassSimpanDaftarTonton.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));
      when(mockClassStatusDaftarTonton.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addwatchlistTv(testTvDetail);
      // assert
      verify(mockClassStatusDaftarTonton.execute(testTvDetail.id));
      expect(provider.isAddedTowatchlistTv, true);
      expect(provider.watchlistMessageTv, 'Added to watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockClassSimpanDaftarTonton.execute(testTvDetail)).thenAnswer(
          (_) async =>
              Left(DatabaseFailure('Upss... Maaf Kami Gagal Memuat Data :(')));
      when(mockClassStatusDaftarTonton.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addwatchlistTv(testTvDetail);
      // assert
      expect(provider.watchlistMessageTv,
          'Upss... Maaf Kami Gagal Memuat Data :(');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvs));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
