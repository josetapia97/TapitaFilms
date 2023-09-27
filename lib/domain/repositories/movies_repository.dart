import 'package:tapitafilms/domain/entities/movie.dart';

abstract class MoviesRepository {

  Future<List<Movie>>  getNowPlaying({int page = 1});

  Future<List<Movie>>  getPupular({int page = 1});

}