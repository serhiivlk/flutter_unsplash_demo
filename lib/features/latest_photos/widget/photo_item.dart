import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';

class PhotoItem extends StatelessWidget {
  final PhotoEntity photo;

  const PhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = photo.width / photo.height;
    return Card(
      elevation: 4,
      child: Column(
        children: <Widget>[
          FullScreenWidget(
            child: Hero(
              tag: photo.urls.small,
              child: AspectRatio(
                aspectRatio: ratio,
                child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  imageUrl: photo.urls.small,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child: ListTile(
              title: Text('by ' + photo.authorName),
              subtitle: Text(
                photo.description,
                maxLines: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
