import 'package:dartz/dartz.dart';
import 'package:cinta_film/common/failure.dart';
import 'package:cinta_film/common/state_enum.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvls_list_notifier_test.mocks.dart';

@GenerateMocks([GetserialTvSaatIniDiPutarls, GetPopularTvls, GetTopRatedTvls])
void main() {
  late TvlsListNotifier provider;
  late MockGetserialTvSaatIniDiPutarls mockGetserialTvSaatIniDiPutar;
  late MockGetPopularTvls mockGetPopularTv;
  late MockGetTopRatedTvls mockGetTopRatedTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetserialTvSaatIniDiPutar = MockGetserialTvSaatIniDiPutarls();
    mockGetPopularTv = MockGetPopularTvls();
    mockGetTopRatedTv = MockGetTopRatedTvls();
    provider = TvlsListNotifier(
      getserialTvSaatIniDiPutarls: mockGetserialTvSaatIniDiPutar,
      getPopularTvls: mockGetPopularTv,
      getTopRatedTvls: mockGetTopRatedTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

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
  final tTvList = <Tvls>[tTv];

  group('Serial Tv Yang Sedang Tayang', () {
    test('initialState should be Empty', () {
      expect(provider.serialTvSaatIniDiPutarState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetserialTvSaatIniDiPutar.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchserialTvSaatIniDiPutar();
      // assert
      verify(mockGetserialTvSaatIniDiPutar.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetserialTvSaatIniDiPutar.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchserialTvSaatIniDiPutar();
      // assert
      expect(provider.serialTvSaatIniDiPutarState, RequestState.Loading);
    });

    test('should change tv when data is gotten successfully', () async {
      // arrange
      when(mockGetserialTvSaatIniDiPutar.execute())
          .thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchserialTvSaatIniDiPutar();
      // assert
      expect(provider.serialTvSaatIniDiPutarState, RequestState.Loaded);
      expect(provider.serialTvSaatIniDiPutar, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetserialTvSaatIniDiPutar.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchserialTvSaatIniDiPutar();
      // assert
      expect(provider.serialTvSaatIniDiPutarState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTv, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Serial Tv Ranting Tertinggi', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.serialTvRatingTerbaikState, RequestState.Loading);
    });

    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(tTvList));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.serialTvRatingTerbaikState, RequestState.Loaded);
      expect(provider.serialTvRatingTerbaik, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.serialTvRatingTerbaikState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
