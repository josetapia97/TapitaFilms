import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/presentation/delegates/search_movie_delegate.dart';
import 'package:tapitafilms/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: SizedBox(
            width: double.infinity,
            child: Row(children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(
                width: 5,
              ),
              Text(
                'TapitaFilms',
                style: titleStyle,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    final searchQuery = ref.read(searchQueryProvider);
                    final searchedMovies = ref.read(searchedMoviesProvider);

                    showSearch<Movie?>(
                        query: searchQuery,
                        context: context,
                        delegate: SearchMovieDelegate(
                          initialMovies: searchedMovies,
                          searchMovies:ref.read(searchedMoviesProvider.notifier).searchedMoviesByQuery                 
                        )
                        ).then((movie) {
                      if (movie == null) return;
                      context.push('/movie/${movie.id}');
                    });
                  },
                  icon: const Icon(Icons.search))
            ]),
          ),
        ));
  }
}
