part of 'latest_photos_bloc.dart';

@immutable
abstract class LatestPhotosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchNextPage extends LatestPhotosEvent {}
