import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tapitafilms/infrastructure/datasources/isar_datasource.dart';
import 'package:tapitafilms/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider(
  (ref) {
    return LocalStorageImpl(IsarDatasource());
  },
);
