import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/presentation/providers/movies/movie_info_provider.dart';
import 'package:tapitafilms/presentation/providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-id';
  final String movieId;
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];
    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppbar(
          movie: movie,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(movie: movie),
            childCount: 1,
          ),
        ),
      ],
    ));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(movie.posterPath, width: size.width * 0.3),
              ),
              const SizedBox(
                width: 10,
              ),
              //? Descripcion

              SizedBox(
                width: (size.width - 70) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(movie.overview),
                  ],
                ),
              )
            ],
          ),
        ),

        // Generos de la pelicula
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        _ActorsByMovie(movieId: (movie.id.toString())),

        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }
    final actors = actorsByMovie[movieId]!;
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index < actors.length) {
            final actor = actors[index];
            return Container(
              padding: const EdgeInsets.all(8.0),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Actor foto
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Nombre
                  const SizedBox(height: 5,),
                  Text(actor.name, maxLines: 2,),
                  Text(actor.character ?? '', maxLines: 2,style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),)
                ],
              ),
            );
          } else {
            // Si el índice está fuera del rango válido, puedes devolver un widget vacío o un mensaje de error, según prefieras.
            return const SizedBox.shrink(); // Devuelve un widget vacío en este caso.
          }
        },
      ),
    );
  }
}

class _CustomSliverAppbar extends StatelessWidget {
  const _CustomSliverAppbar({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        // title: Text(movie.title, style: const TextStyle(fontSize: 20),
        // textAlign: TextAlign.start),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.7, 1.0],
                        colors: [Colors.transparent, Colors.black87])),
              ),
            ),
            const SizedBox.expand(
                child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                    0.0,
                    0.3
                  ],
                      colors: [
                    Colors.black87,
                    Colors.transparent,
                  ])),
            )),
          ],
        ),
      ),
    );
  }
}
