import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ClassFilmTerPopuler usecase;
  late MockRepositoryFilm mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockRepositoryFilm();
    usecase = ClassFilmTerPopuler(mockMovieRpository);
  });

  final tMovies = <Film>[];

  group('ClassFilmTerPopuler Tests', () {
    group('execute', () {
      test(
          'should get list of Film from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.ambilDataFilmTerPopuler())
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
