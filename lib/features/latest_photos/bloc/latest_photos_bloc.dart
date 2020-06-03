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
  LatestPhotosState get initialState => Empty();

  @override
  Stream<LatestPhotosState> mapEventToState(LatestPhotosEvent event) async* {
    print('event: $event');
    final currentState = state;

    if (event is FetchNextPage && !_hasReachedMax(currentState)) {
      try {
        final newState = Loading();
        print('yield state: $newState');
        yield newState;
        if (currentState is Empty) {
          final result = await getLatestPhotosPerPage(
            page: 1,
            pageSize: _PAGE_SIZE,
          );
          final newState = result.toState(
            (list) => Loaded(
              photos: list,
              pageCount: 1,
              hasReachedEndOfResults: list.length < _PAGE_SIZE,
            ),
          );
          print('yield state from empty: $newState');
          yield newState;
          return;
        }
        if (currentState is Loaded) {
          final nextPage = currentState.pageCount + 1;
          final result = await getLatestPhotosPerPage(
              page: nextPage, pageSize: _PAGE_SIZE);
          final newState = result.toState(
            (list) => Loaded(
              photos: currentState.photos + list,
              pageCount: nextPage,
              hasReachedEndOfResults: list.length < _PAGE_SIZE,
            ),
          );
          print('yield state from loaded: $newState');
          yield newState;
          return;
        }
      } catch (e) {
        final newState = Error(message: e.toString());
        print('yield state: $newState');
        yield newState;
      }
    }
  }

  bool _hasReachedMax(LatestPhotosState state) =>
      state is Loaded && state.hasReachedEndOfResults;
}

extension EitherToState on Either<Failure, List<PhotoEntity>> {
  LatestPhotosState toState(
    LatestPhotosState Function(List<PhotoEntity>) whenSuccess,
  ) {
    return this.fold(
      (l) => Error(message: 'Server Error'),
      (r) => whenSuccess(r),
    );
  }
}
