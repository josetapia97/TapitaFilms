import 'package:dio/dio.dart';
import 'package:tapitafilms/config/constant/environment.dart';
import 'package:tapitafilms/domain/datasources/movies_datasource.dart';
import 'package:tapitafilms/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');
    final List<Movie> movies = [];

    return [];
  }
}
