import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:unsplash/data/api/unsplash_api_service.dart';
import 'package:unsplash/data/repositories/unsplash_repository_impl.dart';
import 'package:unsplash/domain/interactors/get_latest_photos.dart';
import 'package:unsplash/domain/repositories/unsplash_repository.dart';

final injector = GetIt.instance;

void init() {
  // use cases
  injector.registerLazySingleton<GetLatestPhotos>(
      () => GetLatestPhotos(repository: injector()));

  // repository
  injector.registerLazySingleton<UnsplashRepository>(
      () => UnsplashRepositoryImpl(apiService: injector()));

  // network
  injector.registerLazySingleton<UnsplashApiService>(
      () => UnsplashApiServiceImpl(client: injector()));

  // external
  injector.registerLazySingleton(() => http.Client());
}
