import 'package:dio/dio.dart';
import 'package:tapitafilms/config/constant/environment.dart';
import 'package:tapitafilms/domain/datasources/movies_datasource.dart';
import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/infrastructure/mappers/movie_mapper.dart';
import 'package:tapitafilms/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  // Esta clase es una implementación concreta de MoviesDatasource que obtiene datos de la API de The Movie Database (TMDb).

  final dio = Dio(BaseOptions(
      baseUrl:'https://api.themoviedb.org/3', // Configura la URL base para las solicitudes a la API de TMDb.
      queryParameters: {
        'api_key': Environment.theMovieDbKey, // Agrega la clave de API a los parámetros de consulta de todas las solicitudes.
        'language':'es-MX' // Configura el idioma de las respuestas de la API a español mexicano.
      }));

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Implementación del método de la interfaz MoviesDatasource para obtener las películas que están en cartelera en este momento.

    final response = await dio.get('/movie/now_playing'); // Realiza una solicitud GET a la API de TMDb para obtener las películas que están en cartelera.
    final movieDbResponse = MovieDbResponse.fromJson(response.data); // Convierte la respuesta JSON en un objeto MovieDbResponse.
    final List<Movie> movies = movieDbResponse.results
      .where((moviedb) => moviedb.posterPath != 'no-poster')
      .map(
      (moviedb) => MovieMapper.movieDbToEntity(moviedb) // Mapea cada objeto MovieMovieDB a un objeto Movie utilizando el método movieDbToEntity de MovieMapper.
            ).toList();

    return movies; // Devuelve la lista de películas mapeadas.
  }
}
