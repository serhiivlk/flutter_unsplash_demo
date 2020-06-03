import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/data/api/error/exceptions.dart';
import 'package:unsplash/data/api/unsplash_api_service.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';
import 'package:unsplash/domain/repositories/unsplash_repository.dart';

class UnsplashRepositoryImpl extends UnsplashRepository {
  final UnsplashApiService apiService;

  UnsplashRepositoryImpl({
    @required this.apiService,
  });

  @override
  Future<Either<Failure, List<PhotoEntity>>> getLatestPhotos() async {
    try {
      final photos = await apiService.getLatestPhotos();
      return Right(photos);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PhotoEntity>>> getLatestPhotosPerPage({
    int page,
    int pageSize,
  }) async {
    try {
      final photos = await apiService.getLatestPhotosPerPage(page, pageSize);
      return Right(photos);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
