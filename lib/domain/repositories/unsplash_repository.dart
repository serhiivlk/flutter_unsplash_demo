import 'package:dartz/dartz.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';

abstract class UnsplashRepository {
  Future<Either<Failure, List<PhotoEntity>>> getLatestPhotos();
}
