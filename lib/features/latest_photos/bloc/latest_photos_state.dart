part of 'latest_photos_bloc.dart';

@immutable
abstract class LatestPhotosState extends Equatable {

  @override
  List<Object> get props => [];

}

class Empty extends LatestPhotosState {}

class Loading extends LatestPhotosState {}

class Loaded extends LatestPhotosState {
  final List<PhotoEntity> photos;
  final int pageCount;
  final bool hasReachedEndOfResults;

  Loaded({
    @required this.photos,
    @required this.pageCount,
    @required this.hasReachedEndOfResults,
  });

  @override
  List<Object> get props => [photos, pageCount, hasReachedEndOfResults];
}

class Error extends LatestPhotosState {
  final String message;

  Error({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
