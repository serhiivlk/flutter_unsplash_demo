import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_urls_entity.dart';

class PhotoEntity extends Equatable {
  final String id;
  final String authorName;
  final String description;
  final int width;
  final int height;
  final PhotoUrls urls;

  PhotoEntity({
    @required this.id,
    @required this.authorName,
    @required this.description,
    @required this.width,
    @required this.height,
    @required this.urls,
  });

  @override
  List<Object> get props => [id, authorName, description, width, height, urls];
}
