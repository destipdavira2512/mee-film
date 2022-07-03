import 'package:cinta_film/domain/repositories/movie_repository.dart';

class ClassStatusDaftarTonton {
  final RepositoryFilm repository;

  ClassStatusDaftarTonton(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedTowatchlist(id);
  }
}
