import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // Define un provider llamado 'nowPlayingMoviesProvider' que utiliza StateNotifier para gestionar el estado de una lista de películas.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(
      fetchMoreMovies:
          fetchMoreMovies); // Crea una instancia de MoviesNotifier y la proporciona como valor inicial para el provider.
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
 
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPupular;
  return MoviesNotifier(
      fetchMoreMovies:
          fetchMoreMovies); // Crea una instancia de MoviesNotifier y la proporciona como valor inicial para el provider.
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  // Esta clase MoviesNotifier extiende StateNotifier y se utiliza para gestionar el estado de una lista de películas.

  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super(
            []); // Constructor de MoviesNotifier que inicializa el estado con una lista vacía de películas.

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
