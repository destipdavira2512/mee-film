import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ClassSimpanDaftarTonton usecase;
  late MockRepositoryFilm mockRepositoryFilm;

  setUp(() {
    mockRepositoryFilm = MockRepositoryFilm();
    usecase = ClassSimpanDaftarTonton(mockRepositoryFilm);
  });

  test('should save film to the repository', () async {
    // arrange
    when(mockRepositoryFilm.daftarTonton(testMovieDetail))
        .thenAnswer((_) async => Right('Added to watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockRepositoryFilm.daftarTonton(testMovieDetail));
    expect(result, Right('Added to watchlist'));
  });
}
