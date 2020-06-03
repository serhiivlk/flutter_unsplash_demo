import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash/domain/entities/photo_entity.dart';
import 'package:unsplash/domain/entities/photo_urls_entity.dart';

void main() {
  test('two photo entities with some field should be equivalent', () {
    final photo1 = PhotoEntity(
      id: 'foo_id',
      authorName: 'foo_author_name',
      width: 120,
      height: 340,
      urls: PhotoUrls(
        thumbnail: 'foo_thumbnail',
        small: 'foo_small',
        full: 'foo_full',
      ),
    );
    final photo2 = PhotoEntity(
      id: 'foo_id',
      authorName: 'foo_author_name',
      width: 120,
      height: 340,
      urls: PhotoUrls(
        thumbnail: 'foo_thumbnail',
        small: 'foo_small',
        full: 'foo_full',
      ),
    );

    expect(photo1, equals(photo2));
  });
}
