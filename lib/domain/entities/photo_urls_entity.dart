import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PhotoUrls extends Equatable {
  final String thumbnail;
  final String small;
  final String full;

  PhotoUrls({
    @required this.thumbnail,
    @required this.small,
    @required this.full,
  });

  @override
  List<Object> get props => [thumbnail, small, full];
}
