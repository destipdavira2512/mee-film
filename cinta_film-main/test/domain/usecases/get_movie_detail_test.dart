import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieDetail usecase;
  late MockRepositoryFilm mockRepositoryFilm;

  setUp(() {
    mockRepositoryFilm = MockRepositoryFilm();
    usecase = GetMovieDetail(mockRepositoryFilm);
  });

  final tId = 1;

  test('should get film detail from the repository', () async {
    // arrange
    when(mockRepositoryFilm.getMovieDetail(tId))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
