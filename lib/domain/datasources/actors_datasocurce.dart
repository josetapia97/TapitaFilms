import 'package:tapitafilms/domain/entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getactorsByMovie(String movieId);
}
