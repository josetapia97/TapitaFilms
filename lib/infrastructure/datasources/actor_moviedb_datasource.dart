import 'package:dio/dio.dart';
import 'package:tapitafilms/config/constant/environment.dart';
import 'package:tapitafilms/domain/datasources/actors_datasocurce.dart';
import 'package:tapitafilms/domain/entities/actor.dart';
import 'package:tapitafilms/infrastructure/mappers/actor_maper.dart';
import 'package:tapitafilms/infrastructure/models/moviedb/credits_response.dart';

final dio = Dio(BaseOptions(
    baseUrl:
        'https://api.themoviedb.org/3', // Configura la URL base para las solicitudes a la API de TMDb.
    queryParameters: {
      'api_key': Environment
          .theMovieDbKey, // Agrega la clave de API a los parámetros de consulta de todas las solicitudes.
      'language':
          'es-MX' // Configura el idioma de las respuestas de la API a español mexicano.
    }));

List<Actor> _jsonToActors(Map<String, dynamic> json) {
  final actorMDbResponse = CreditsResponse.fromJson(
      json); // Convierte la respuesta JSON en un objeto MovieDbResponse.
  final List<Actor> actores = actorMDbResponse.cast
      .map((actors) => ActorMapper.castToEntity(
              actors) // Mapea cada objeto MovieMovieDB a un objeto Movie utilizando el método movieDbToEntity de MovieMapper.
          )
      .toList();

  return actores; // Devuelve la lista de películas mapeadas.
}

class ActorMovieDbDatasource extends ActorsDatasource {
  @override
  Future<List<Actor>> getactorsByMovie(String movieId) async {
    final response = await dio.get('movie/$movieId/credits');

     return _jsonToActors(response.data);

  }
}
