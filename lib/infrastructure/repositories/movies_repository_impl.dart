import 'package:tapitafilms/domain/datasources/movies_datasource.dart';
import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;
  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPupular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
}
