import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/data/models/movie_table.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/repositories/movie_repository.dart';
import 'package:cinta_film/common/exception.dart';
import 'package:cinta_film/common/failure.dart';

class RepositoryFilmImpl implements RepositoryFilm {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  RepositoryFilmImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Film>>> filmTayangSaatIni() async {
    try {
      final result = await remoteDataSource.filmTayangSaatIni();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> ambilDataFilmTerPopuler() async {
    try {
      final result = await remoteDataSource.ambilDataFilmTerPopuler();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> ambilFilmRatingTerbaik() async {
    try {
      final result = await remoteDataSource.ambilFilmRatingTerbaik();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Film>>> cariFilm(String query) async {
    try {
      final result = await remoteDataSource.cariFilm(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> daftarTonton(MovieDetail film) async {
    try {
      final result =
          await localDataSource.insertwatchlist(MovieTable.fromEntity(film));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removewatchlist(MovieDetail film) async {
    try {
      final result =
          await localDataSource.removewatchlist(MovieTable.fromEntity(film));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedTowatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Film>>> ambilDaftarTontonFilm() async {
    final result = await localDataSource.ambilDaftarTontonFilm();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
