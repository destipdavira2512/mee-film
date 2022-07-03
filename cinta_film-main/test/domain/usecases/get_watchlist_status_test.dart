import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ClassStatusDaftarTonton usecase;
  late MockRepositoryFilm mockRepositoryFilm;

  setUp(() {
    mockRepositoryFilm = MockRepositoryFilm();
    usecase = ClassStatusDaftarTonton(mockRepositoryFilm);
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockRepositoryFilm.isAddedTowatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });
}
