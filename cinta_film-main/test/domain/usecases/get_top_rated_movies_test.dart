import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ClassFilmRatingTerbaik usecase;
  late MockRepositoryFilm mockRepositoryFilm;

  setUp(() {
    mockRepositoryFilm = MockRepositoryFilm();
    usecase = ClassFilmRatingTerbaik(mockRepositoryFilm);
  });

  final tMovies = <Film>[];

  test('should get list of Film from repository', () async {
    // arrange
    when(mockRepositoryFilm.ambilFilmRatingTerbaik())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
