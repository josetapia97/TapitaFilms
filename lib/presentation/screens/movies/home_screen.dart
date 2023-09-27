import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapitafilms/presentation/providers/providers.dart';
import 'package:tapitafilms/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate((context, index){
          return Column(
        children: [
          // const CustomAppbar(),
          MoviesSlideshow(movies: slideShowMovies),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En cines',
            subTitle: 'Septiembre',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
            
          ),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Próximamente',
            subTitle: 'Estrenos',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
            
          ),
          MovieHorizontalListview(
            movies: popularMovies,
            title: 'Populares',
            //subTitle: 'Revisa tu cartelera',
            loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
            
          ),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Mejor calificadas',
            subTitle: 'Desde siempre',
            loadNextPage: () => ref.read(nowPlayingMoviesProvider.notifier).loadNextPage()
            
          ),
          const SizedBox(height: 25,)
        ],
      );
        },
        childCount: 1)
        )
      ],
    );
  }
}
