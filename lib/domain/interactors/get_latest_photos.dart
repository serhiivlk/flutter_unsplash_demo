import 'package:dartz/dartz.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';

import '../repositories/unsplash_repository.dart';

class GetLatestPhotos {
  final UnsplashRepository repository;

  GetLatestPhotos(this.repository);

  Future<Either<Failure, List<PhotoEntity>>> call() async {
    return await repository.getLatestPhotos();
  }
}
