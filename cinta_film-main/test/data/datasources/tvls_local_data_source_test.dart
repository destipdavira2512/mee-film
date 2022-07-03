import 'package:cinta_film/common/exception.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late TvlsLocalDataSourceImpl dataSourcetv;
  late MockDatabaseHelperTvls mockDatabaseHelperTv;

  setUp(() {
    mockDatabaseHelperTv = MockDatabaseHelperTvls();
    dataSourcetv =
        TvlsLocalDataSourceImpl(databaseHelpertvls: mockDatabaseHelperTv);
  });

  group('save watchlist tv', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertwatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSourcetv.insertwatchlistTv(testTvTable);
      // assert
      expect(result, 'Added to watchlist');
    });

    test('should throw DatabaseException when insert tv to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.insertwatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourcetv.insertwatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist tv', () {
    test(
        'should throw DatabaseException when remove tv from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperTv.removewatchlistTv(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSourcetv.removewatchlistTv(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    final tId = 1;

    test('should return Tv Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSourcetv.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperTv.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSourcetv.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of TvTable from database', () async {
      // arrange
      when(mockDatabaseHelperTv.getwatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSourcetv.getwatchlistTv();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
