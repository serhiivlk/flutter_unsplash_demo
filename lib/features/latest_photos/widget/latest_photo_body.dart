import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/features/latest_photos/bloc/latest_photos_bloc.dart';
import 'package:unsplash/features/latest_photos/widget/bottom_loading.dart';
import 'package:unsplash/features/latest_photos/widget/photo_item.dart';

class LatestPhotosBody extends StatefulWidget {
  @override
  _LatestPhotosBodyState createState() => _LatestPhotosBodyState();
}

class _LatestPhotosBodyState extends State<LatestPhotosBody> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  LatestPhotosBloc _bloc;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    _bloc = BlocProvider.of<LatestPhotosBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestPhotosBloc, LatestPhotosState>(
      builder: (context, state) {
        print('state: $state');

        if (state.error.isNotEmpty) {
          return _errorBody(state.error);
        }
        if (state.isLoading) {
          return _loadingBody();
        }
        if (state.photos.isEmpty) {
          return _emptyBody();
        }
        return _listBody(state.photos, state.hasReachedEndOfResults);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _bloc.add(FetchNextPage());
    }
  }

  Widget _emptyBody() => Center(
        child: Text('No Photo'),
      );

  Widget _loadingBody() => Center(
        child: CircularProgressIndicator(),
      );

  Widget _errorBody(String message) => Center(
        child: Text(message),
      );

//  Widget _listBody(Loaded state) => ListView.builder(
//        itemBuilder: (context, index) {
//          return index >= state.photos.length
//              ? BottomLoading()
//              : PhotoItem(photo: state.photos[index]);
//        },
//        itemCount: state.photos.length + (state.hasReachedEndOfResults ? 0 : 1),
//        controller: _scrollController,
//      );
  Widget _listBody(List<PhotoEntity> photos, bool hasNext) => ListView.builder(
        itemBuilder: (context, index) {
          return index >= photos.length
              ? BottomLoading()
              : PhotoItem(photo: photos[index]);
        },
        itemCount: photos.length + (hasNext ? 0 : 1),
        controller: _scrollController,
      );
}
