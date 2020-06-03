import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:unsplash/data/api/models/photo_raw.dart';
import 'package:unsplash/data/api/models/photo_urls_raw.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  test('converting from json should returned correct data', () {
    final Map<String, dynamic> jsonMap = json.decode(readFixture('photo.json'));

    final photoRaw = jsonMap.jsonToPhotoRaw();

    final urls = PhotoUrlsRaw(
      thumbnail: 'test_thumb_url',
      small: 'test_small_url',
      full: 'test_full_url',
    );
    final photo = PhotoRaw(
      id: 'test_id',
      authorName: 'test_user_name',
      urls: urls,
    );

    expect(photoRaw, equals(photo));
  });

  test('converting from json list should returned correct data', () {
    final list = json.decode(readFixture('photo_list.json')) as List;
    final photoRaws =
        list.cast<Map<String, dynamic>>().map((item) => item.jsonToPhotoRaw());

    final urls = PhotoUrlsRaw(
      thumbnail: 'test_thumb_url',
      small: 'test_small_url',
      full: 'test_full_url',
    );
    final photo = PhotoRaw(
      id: 'test_id',
      authorName: 'test_user_name',
      urls: urls,
    );

    expect(photoRaws, equals([photo]));
  });
}
