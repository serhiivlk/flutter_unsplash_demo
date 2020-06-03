import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';

abstract class UnsplashRepository {
  Future<Either<Failure, List<PhotoEntity>>> getLatestPhotos();

  Future<Either<Failure, List<PhotoEntity>>> getLatestPhotosPerPage({
    @required int page,
    @required int pageSize,
  });
}
