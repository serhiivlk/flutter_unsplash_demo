part of 'latest_photos_bloc.dart';

@immutable
class LatestPhotosState extends Equatable {
  final bool isLoading;

  final List<PhotoEntity> photos;
  final bool hasReachedEndOfResults;

  final String error;

  bool get isEmpty => photos.isEmpty;

  const LatestPhotosState({
    @required this.isLoading,
    @required this.photos,
    @required this.hasReachedEndOfResults,
    @required this.error,
  });

  @override
  List<Object> get props => [
        isLoading,
        photos,
        hasReachedEndOfResults,
        error,
      ];

  LatestPhotosState copyWith({
    bool isLoading,
    List<PhotoEntity> photos,
    bool hasReachedEndOfResults,
    String error,
  }) {
    return LatestPhotosState(
      isLoading: isLoading ?? this.isLoading,
      photos: photos ?? this.photos,
      hasReachedEndOfResults:
          hasReachedEndOfResults ?? this.hasReachedEndOfResults,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => '''
      LatestPhotosState {
        isLoading: $isLoading,
        photos: ${photos.length},
        hasReachedEndOfResults: $hasReachedEndOfResults,
        error: $error
      ''';

  factory LatestPhotosState.initial() => LatestPhotosState(
        isLoading: false,
        photos: <PhotoEntity>[],
        hasReachedEndOfResults: false,
        error: '',
      );
}
