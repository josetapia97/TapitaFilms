import 'package:dio/dio.dart';
import 'package:tapitafilms/config/constant/environment.dart';
import 'package:tapitafilms/domain/datasources/movies_datasource.dart';
import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/infrastructure/mappers/movie_mapper.dart';
import 'package:tapitafilms/infrastructure/models/moviedb/movie_details.dart';
import 'package:tapitafilms/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  // Esta clase es una implementación concreta de MoviesDatasource que obtiene datos de la API de The Movie Database (TMDb).

  final dio = Dio(BaseOptions(
      baseUrl:
          'https://api.themoviedb.org/3', // Configura la URL base para las solicitudes a la API de TMDb.
      queryParameters: {
        'api_key': Environment
            .theMovieDbKey, // Agrega la clave de API a los parámetros de consulta de todas las solicitudes.
        'language':
            'es-MX' // Configura el idioma de las respuestas de la API a español mexicano.
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(
        json); // Convierte la respuesta JSON en un objeto MovieDbResponse.
    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDbToEntity(
                moviedb) // Mapea cada objeto MovieMovieDB a un objeto Movie utilizando el método movieDbToEntity de MovieMapper.
            )
        .toList();

    return movies; // Devuelve la lista de películas mapeadas.
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Implementación del método de la interfaz MoviesDatasource para obtener las películas que están en cartelera en este momento.

    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page
    }); // Realiza una solicitud GET a la API de TMDb para obtener las películas que están en cartelera.
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    // Implementación del método de la interfaz MoviesDatasource para obtener las películas que están en cartelera en este momento.

    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page
    }); // Realiza una solicitud GET a la API de TMDb para obtener las películas que están en cartelera.
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page
    }); // Realiza una solicitud GET a la API de TMDb para obtener las películas que están en cartelera.
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page
    }); // Realiza una solicitud GET a la API de TMDb para obtener las películas que están en cartelera.
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id:$id not found');
    }
    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailstoEntity(movieDetails);
    return movie;
  }
}
