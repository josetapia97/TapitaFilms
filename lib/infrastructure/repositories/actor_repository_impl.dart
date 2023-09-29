import 'package:tapitafilms/domain/datasources/actors_datasocurce.dart';
import 'package:tapitafilms/domain/entities/actor.dart';
import 'package:tapitafilms/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);
  @override
  Future<List<Actor>> getactorsByMovie(String movieId) {
    return datasource.getactorsByMovie(movieId);
  }
}
