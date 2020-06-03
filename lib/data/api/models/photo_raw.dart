import 'package:meta/meta.dart';
import 'package:unsplash/data/api/models/photo_urls_raw.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';

class PhotoRaw extends PhotoEntity {
  PhotoRaw({
    @required String id,
    @required String authorName,
    @required int width,
    @required int height,
    @required PhotoUrlsRaw urls,
  }) : super(
          id: id,
          width: width,
          height: height,
          authorName: authorName,
          urls: urls,
        );
}

extension PhotoRawJsonConverter on Map<String, dynamic> {
  PhotoRaw jsonToPhotoRaw() {
    final Map<String, dynamic> urlsMap = this['urls'];
    final Map<String, dynamic> userMap = this['user'];

    return PhotoRaw(
      id: this['id'],
      width: this['width'],
      height: this['height'],
      authorName: userMap['name'],
      urls: urlsMap.jsonToPhotoUrlsRaw(),
    );
  }
}
