import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';
import 'package:unsplash/domain/repositories/unsplash_repository.dart';

class GetLatestPhotosPerPage {
  final UnsplashRepository repository;

  GetLatestPhotosPerPage({
    @required this.repository,
  });

  Future<Either<Failure, List<PhotoEntity>>> call({
    @required int page,
    @required int pageSize,
  }) async {
    return await repository.getLatestPhotosPerPage(
      page: page,
      pageSize: pageSize,
    );
  }
}
