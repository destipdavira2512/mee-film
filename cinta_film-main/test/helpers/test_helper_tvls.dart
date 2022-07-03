import 'package:cinta_film/data/datasources/db/database_helper_tvls.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvlsRepository,
  TvlsRemoteDataSource,
  TvlsLocalDataSource,
  DatabaseHelperTvls,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
