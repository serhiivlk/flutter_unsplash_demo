import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:unsplash/domain/entities/photo_urls_entity.dart';

class PhotoUrlsRaw extends PhotoUrls {
  PhotoUrlsRaw({
    @required String thumbnail,
    @required String small,
    @required String full,
  }) : super(
          thumbnail: thumbnail,
          small: small,
          full: full,
        );
}

extension PhotoUrlsJsonConverter on Map<String, dynamic> {
  PhotoUrlsRaw jsonToPhotoUrlsRaw() {
    return PhotoUrlsRaw(
      thumbnail: this['thumb'],
      small: this['small'],
      full: this['full'],
    );
  }
}
