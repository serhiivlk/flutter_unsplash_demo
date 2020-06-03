import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';
import 'package:unsplash/domain/interactors/get_latest_photos_per_page.dart';

part 'latest_photos_event.dart';
part 'latest_photos_state.dart';

const _PAGE_SIZE = 10;

class LatestPhotosBloc extends Bloc<LatestPhotosEvent, LatestPhotosState> {
  final GetLatestPhotosPerPage getLatestPhotosPerPage;
  int lastLoadedPage = 1;

  LatestPhotosBloc({
    @required this.getLatestPhotosPerPage,
  });

  @override
  LatestPhotosState get initialState => LatestPhotosState.initial();

  @override
  Stream<LatestPhotosState> mapEventToState(LatestPhotosEvent event) async* {
    print('event: $event');
    final currentState = state;

    try {
      if (event is Initialize) {
        yield currentState.copyWith(isLoading: true);
        final result = await getLatestPhotosPerPage(
          page: 1,
          pageSize: _PAGE_SIZE,
        );
        yield result.toState(
            currentState,
            (list) => currentState.copyWith(
                  isLoading: false,
                  photos: list,
                  hasReachedEndOfResults: list.length < _PAGE_SIZE,
                ));
        return;
      }
      if (event is FetchNextPage) {
        final loadedPageCount =
            (currentState.photos.length / _PAGE_SIZE).ceil();
        final nextPage = loadedPageCount + 1;
        final result =
            await getLatestPhotosPerPage(page: nextPage, pageSize: _PAGE_SIZE);
        yield result.toState(
          currentState,
          (list) => currentState.copyWith(
            isLoading: false,
            photos: currentState.photos + list,
            hasReachedEndOfResults: list.length < _PAGE_SIZE,
          ),
        );
      }
    } catch (e) {
      yield currentState.copyWith(isLoading: false, error: e.toString());
    }
  }

//  bool _hasReachedMax(LatestPhotosState state) =>
//      state is Loaded && state.hasReachedEndOfResults;
}

extension EitherToState on Either<Failure, List<PhotoEntity>> {
  LatestPhotosState toState(LatestPhotosState initState,
      LatestPhotosState Function(List<PhotoEntity>) whenSuccess,) {
    return this.fold(
          (l) => initState.copyWith(error: 'Server Error'),
          (r) => whenSuccess(r),
    );
  }
}
