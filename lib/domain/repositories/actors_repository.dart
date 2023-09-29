import 'package:tapitafilms/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getactorsByMovie(String movieId);
}