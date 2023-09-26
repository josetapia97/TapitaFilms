import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapitafilms/infrastructure/datasources/moviedb_datasource.dart';
import 'package:tapitafilms/infrastructure/repositories/movies_repository_impl.dart';

//Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
