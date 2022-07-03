import 'package:cinta_film/data/datasources/db/database_helper.dart';
import 'package:cinta_film/data/datasources/db/database_helper_tvls.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/data/repositories/movie_repository_impl.dart';
import 'package:cinta_film/data/repositories/tvls_repository_impl.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:cinta_film/domain/repositories/tvls_repository.dart';
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart';
import 'package:cinta_film/domain/usecases/ambil_data_tayang_saat_ini.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_terpopuler.dart';
import 'package:cinta_film/domain/usecases/ambil_data_film_rating_terbaik.dart';
import 'package:cinta_film/domain/usecases/ambil_daftar_tonton_film.dart';
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/daftar_tonton.dart';
import 'package:cinta_film/domain/usecases/cari_film.dart';
import 'package:cinta_film/domain/usecases/tvls/get_now_playing_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_popular_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_top_rated_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_detail.dart';
import 'package:cinta_film/domain/usecases/tvls/get_tvls_recomendations.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_status_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/get_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/remove_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/save_watchlist_tvls.dart';
import 'package:cinta_film/domain/usecases/tvls/search_tvls.dart';
import 'package:cinta_film/presentasi/provider/movie_detail_notifier.dart';
import 'package:cinta_film/presentasi/provider/movie_list_notifier.dart';
import 'package:cinta_film/presentasi/provider/movie_search_notifier.dart';
import 'package:cinta_film/presentasi/provider/get_data_film_terpopuler.dart';
import 'package:cinta_film/presentasi/provider/frame_pesan_film_terpopuler.dart';
import 'package:cinta_film/presentasi/provider/watchlist_movie_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/popular_tvls_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/top_rated_tvls_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_detail_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_list_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/tvls_search_notifier.dart';
import 'package:cinta_film/presentasi/provider/tvls/watchlist_tvls_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      filmTayangSaatIni: locator(),
      getPopularMovies: locator(),
      ambilFilmRatingTerbaik: locator(),
    ),
  );
  locator.registerFactory(
    () => TvlsListNotifier(
      getserialTvSaatIniDiPutarls: locator(),
      getPopularTvls: locator(),
      getTopRatedTvls: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getwatchlistStatus: locator(),
      savewatchlist: locator(),
      removewatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvlsDetailNotifier(
      getTvlsDetail: locator(),
      getTvlsRecommendations: locator(),
      getwatchlistStatusTvls: locator(),
      savewatchlistTvls: locator(),
      removewatchlistTvls: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      cariFilm: locator(),
    ),
  );
  locator.registerFactory(
    () => TvlsSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => NotifikasiFilmTerPopuler(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvlsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      ambilFilmRatingTerbaik: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvlsNotifier(
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => NotifikasiDaftarTontonFilm(
      ambilDaftarTontonFilm: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvlsNotifier(
      getwatchlistTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => ClasFilmTayangSaatIni(locator()));
  locator.registerLazySingleton(() => ClassFilmTerPopuler(locator()));
  locator.registerLazySingleton(() => ClassFilmRatingTerbaik(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => AmbilDataRekomendasiFilm(locator()));
  locator.registerLazySingleton(() => ClassCariFilm(locator()));
  locator.registerLazySingleton(() => ClassStatusDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassSimpanDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassHapusDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassDaftarTontonFilm(locator()));

  locator.registerLazySingleton(() => GetserialTvSaatIniDiPutarls(locator()));
  locator.registerLazySingleton(() => GetPopularTvls(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvls(locator()));
  locator.registerLazySingleton(() => GetTvlsDetail(locator()));
  locator.registerLazySingleton(() => GetTvlsRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvls(locator()));
  locator.registerLazySingleton(() => ClassStatusDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => ClassSimpanDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => ClassHapusDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => GetwatchlistTvls(locator()));
  // repository
  locator.registerLazySingleton<RepositoryFilm>(
    () => RepositoryFilmImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvlsRepository>(
    () => TvlsRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvlsRemoteDataSource>(
      () => TvlsRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvlsLocalDataSource>(
      () => TvlsLocalDataSourceImpl(databaseHelpertvls: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvls>(() => DatabaseHelperTvls());

  // external
  locator.registerLazySingleton(() => http.Client());
}
