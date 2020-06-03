import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/error/failure.dart';
import 'package:unsplash/domain/interactors/get_latest_photos.dart';

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
        return _buildPhotoItem(photo);
      },
    );
  }

  Widget _buildPhotoItem(PhotoEntity photo) {
    final ratio = photo.width / photo.height;
    return Card(
      elevation: 4,
      child: AspectRatio(
        aspectRatio: ratio,
        child: CachedNetworkImage(
          placeholder: (context, url) {
            return CircularProgressIndicator();
          },
          imageUrl: photo.urls.small,
        ),
      ),
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
}
