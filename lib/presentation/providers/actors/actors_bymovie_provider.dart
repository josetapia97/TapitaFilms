import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapitafilms/presentation/providers/actors/actors_repository_provider.dart';
import '../../../domain/entities/actor.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorByMovieNotifier, Map<String,List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorsRepositoryProvider);
  return ActorByMovieNotifier(getActors: actorsRepository.getactorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);


class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;
  ActorByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actors = await getActors(movieId);
    state = {...state, movieId: actors};
  }
}
