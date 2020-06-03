import 'package:meta/meta.dart';
import 'package:unsplash/data/api/models/photo_urls_raw.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';

class PhotoRaw extends PhotoEntity {
  PhotoRaw({
    @required String id,
    @required String authorName,
    @required PhotoUrlsRaw urls,
  }) : super(id: id, authorName: authorName, urls: urls);
}

extension PhotoRawJsonConverter on Map<String, dynamic> {
  PhotoRaw jsonToPhotoRaw() {
    final Map<String, dynamic> urlsMap = this['urls'];
    final Map<String, dynamic> userMap = this['user'];

    return PhotoRaw(
      id: this['id'],
      authorName: userMap['name'],
      urls: urlsMap.jsonToPhotoUrlsRaw(),
    );
  }
}
