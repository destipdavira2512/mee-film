// Mocks generated by Mockito 5.2.0 from annotations
// in cinta_film/test/presentasi/provider/movie_detail_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:cinta_film/common/failure.dart' as _i6;
import 'package:cinta_film/domain/entities/film.dart' as _i9;
import 'package:cinta_film/domain/entities/movie_detail.dart' as _i7;
import 'package:cinta_film/domain/repositories/movie_repository.dart' as _i2;
import 'package:cinta_film/domain/usecases/ambil_data_detail_film.dart' as _i4;
import 'package:cinta_film/domain/usecases/ambil_data_film_rekomendasi.dart'
    as _i8;
import 'package:cinta_film/domain/usecases/ambil_status_daftar_tonton.dart'
    as _i10;
import 'package:cinta_film/domain/usecases/daftar_tonton.dart' as _i11;
import 'package:cinta_film/domain/usecases/hapus_daftar_tonton.dart' as _i12;
import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRepositoryFilm_0 extends _i1.Fake implements _i2.RepositoryFilm {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetMovieDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieDetail extends _i1.Mock implements _i4.GetMovieDetail {
  MockGetMovieDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RepositoryFilm get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRepositoryFilm_0()) as _i2.RepositoryFilm);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.MovieDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.MovieDetail>>.value(
              _FakeEither_1<_i6.Failure, _i7.MovieDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.MovieDetail>>);
}

/// A class which mocks [AmbilDataRekomendasiFilm].
///
/// See the documentation for Mockito's code generation for more information.
class MockAmbilDataRekomendasiFilm extends _i1.Mock
    implements _i8.AmbilDataRekomendasiFilm {
  MockAmbilDataRekomendasiFilm() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RepositoryFilm get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRepositoryFilm_0()) as _i2.RepositoryFilm);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.Film>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.Film>>>.value(
              _FakeEither_1<_i6.Failure, List<_i9.Film>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.Film>>>);
}

/// A class which mocks [ClassStatusDaftarTonton].
///
/// See the documentation for Mockito's code generation for more information.
class MockClassStatusDaftarTonton extends _i1.Mock
    implements _i10.ClassStatusDaftarTonton {
  MockClassStatusDaftarTonton() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RepositoryFilm get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRepositoryFilm_0()) as _i2.RepositoryFilm);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [ClassSimpanDaftarTonton].
///
/// See the documentation for Mockito's code generation for more information.
class MockClassSimpanDaftarTonton extends _i1.Mock
    implements _i11.ClassSimpanDaftarTonton {
  MockClassSimpanDaftarTonton() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RepositoryFilm get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRepositoryFilm_0()) as _i2.RepositoryFilm);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.MovieDetail? film) =>
      (super.noSuchMethod(Invocation.method(#execute, [film]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [ClassHapusDaftarTonton].
///
/// See the documentation for Mockito's code generation for more information.
class MockClassHapusDaftarTonton extends _i1.Mock
    implements _i12.ClassHapusDaftarTonton {
  MockClassHapusDaftarTonton() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RepositoryFilm get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRepositoryFilm_0()) as _i2.RepositoryFilm);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(_i7.MovieDetail? film) =>
      (super.noSuchMethod(Invocation.method(#execute, [film]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither_1<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
