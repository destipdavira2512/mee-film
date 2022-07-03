import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tvls.dart';
import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetTvlsDetail usecase;
  late MockTvlsRepository mockRepositoryFilm;

  setUp(() {
    mockRepositoryFilm = MockTvlsRepository();
    usecase = GetTvlsDetail(mockRepositoryFilm);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockRepositoryFilm.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });
}
