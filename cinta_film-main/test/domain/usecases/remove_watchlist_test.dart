import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late ClassHapusDaftarTonton usecase;
  late MockRepositoryFilm mockRepositoryFilm;

  setUp(() {
    mockRepositoryFilm = MockRepositoryFilm();
    usecase = ClassHapusDaftarTonton(mockRepositoryFilm);
  });

  test('should remove watchlist film from repository', () async {
    // arrange
    when(mockRepositoryFilm.removewatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    verify(mockRepositoryFilm.removewatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
