import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:unsplash/data/api/api_keys.dart';
import 'package:unsplash/data/api/error/exceptions.dart';
import 'package:unsplash/data/api/models/photo_raw.dart';

const _baseUrl = 'https://api.unsplash.com/';

abstract class UnsplashApiService {
  Future<List<PhotoRaw>> getLatestPhotos();

  Future<List<PhotoRaw>> getLatestPhotosPerPage(int page, int perPage);
}

class UnsplashApiServiceImpl implements UnsplashApiService {
  final http.Client client;

  UnsplashApiServiceImpl({
    @required this.client,
  });

  @override
  Future<List<PhotoRaw>> getLatestPhotosPerPage(int page, int perPage) async {
    final url = _baseUrl + 'photos?page=$page&pageper_page=$perPage';
    final response = await client.get(
      url,
      headers: {'Authorization': 'Client-ID ${ApiKeys.accessKey}'},
    );

    if (response.statusCode == 200) {
      final list =
          (json.decode(response.body) as List).cast<Map<String, dynamic>>();
      var photos = list.map((e) => e.jsonToPhotoRaw()).toList();
      return photos;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PhotoRaw>> getLatestPhotos() async {
    final url = _baseUrl + 'photos?per_page=30';
    final response = await client.get(
      url,
      headers: {'Authorization': 'Client-ID ${ApiKeys.accessKey}'},
    );

    if (response.statusCode == 200) {
      final list =
          (json.decode(response.body) as List).cast<Map<String, dynamic>>();
      var photos = list.map((e) => e.jsonToPhotoRaw()).toList();
      return photos;
    } else {
      throw ServerException();
    }
  }
}
