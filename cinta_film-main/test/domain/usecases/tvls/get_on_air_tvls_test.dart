import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper_tvls.mocks.dart';

void main() {
  late GetserialTvSaatIniDiPutarls usecase;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvlsRepository();
    usecase = GetserialTvSaatIniDiPutarls(mockTvRepository);
  });

  final tTv = <Tvls>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getserialTvSaatIniDiPutar())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTv));
  });
}
