import 'package:tapitafilms/domain/entities/movie.dart';
import 'package:tapitafilms/infrastructure/models/moviedb/movie_details.dart';
import 'package:tapitafilms/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  // Esta clase es una utilidad para mapear objetos MovieMovieDB a objetos Movie.

  // El método static movieDbToEntity realiza el mapeo y retorna un objeto Movie.

  static Movie movieDbToEntity(MovieMovieDB moviedb) => Movie(
      adult: moviedb
          .adult, // Mapea la propiedad adult de moviedb a la propiedad adult de Movie.
      backdropPath: (moviedb.backdropPath !=
              '') // Comprueba si backdropPath no está vacío.
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' // Si no está vacío, construye una URL completa para la imagen de fondo utilizando la URL base y backdropPath de moviedb.
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', // Si está vacío, utiliza una URL de imagen de respaldo.
      genreIds: moviedb.genreIds
          .map((e) => e.toString())
          .toList(), // Mapea genreIds convirtiendo cada elemento a una cadena y creando una lista de cadenas.
      id: moviedb.id, // Mapea id de moviedb a id de Movie.
      originalLanguage: moviedb
          .originalLanguage, // Mapea originalLanguage de moviedb a originalLanguage de Movie.
      originalTitle: moviedb
          .originalTitle, // Mapea originalTitle de moviedb a originalTitle de Movie.
      overview:
          moviedb.overview, // Mapea overview de moviedb a overview de Movie.
      popularity: moviedb
          .popularity, // Mapea popularity de moviedb a popularity de Movie.
      posterPath: (moviedb.posterPath !=
              '') // Comprueba si posterPath no está vacío.
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}' // Si no está vacío, construye una URL completa para la imagen del póster utilizando la URL base y posterPath de moviedb.
          : 'no-poster', // Si está vacío, utiliza una URL de imagen de respaldo.
      releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now() , // Mapea releaseDate de moviedb a releaseDate de Movie.
      title: moviedb.title, // Mapea title de moviedb a title de Movie.
      video: moviedb.video, // Mapea video de moviedb a video de Movie.
      voteAverage: moviedb
          .voteAverage, // Mapea voteAverage de moviedb a voteAverage de Movie.
      voteCount: moviedb
          .voteCount); // Mapea voteCount de moviedb a voteCount de Movie.

  static Movie movieDetailstoEntity(MovieDetails moviedb) => Movie(
    adult: moviedb.adult, 
      backdropPath: (moviedb.backdropPath != '') 
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' 
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
      genreIds: moviedb.genres.map((e) => e.name).toList(), 
      id: moviedb.id, 
      originalLanguage: moviedb.originalLanguage, 
      originalTitle: moviedb.originalTitle, 
      overview: moviedb.overview, 
      popularity: moviedb.popularity, 
      posterPath: (moviedb.posterPath != '') 
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}' 
          : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg', 
      releaseDate: moviedb.releaseDate, 
      title: moviedb.title, 
      video: moviedb.video,
      voteAverage: moviedb.voteAverage, 
      voteCount: moviedb.voteCount
  );
}
