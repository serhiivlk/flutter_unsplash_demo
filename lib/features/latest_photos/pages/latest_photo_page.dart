import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';
import 'package:unsplash/domain/interactors/get_latest_photos.dart';
import 'package:unsplash/features/latest_photos/widget/photo_item.dart';
import 'package:unsplash/features/phoho_detail/pages/photo_detail_page.dart';

class LatestPhotosPage extends StatelessWidget {
  final GetLatestPhotos getLatestPhotos;

  const LatestPhotosPage({
    Key key,
    @required this.getLatestPhotos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latest Photos',
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<Either<Failure, List<PhotoEntity>>>(
      future: getLatestPhotos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final result = snapshot.data;
          return result.fold(
              (l) => _buildServerError(), (r) => _buildPhotosList(r));
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildPhotosList(List<PhotoEntity> photos) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return InkWell(
          child: PhotoItem(
            photo: photo,
          ),
//          onTap: () => _navigateToPhotoDetail(context, photo),
        );
      },
    );
  }

  Widget _buildServerError() {
    return Center(
      child: Text('Server Error!!!'),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _navigateToPhotoDetail(BuildContext context, PhotoEntity photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PhotoDetailPage(
              photoUrl: photo.urls.full,
            ),
      ),
    );
  }
}
