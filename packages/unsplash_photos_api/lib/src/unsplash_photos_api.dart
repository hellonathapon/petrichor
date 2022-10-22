import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unsplash_photos_api/unsplash_photos_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PhotoRequestFailure implements Exception {}

class UnsplashPhotosApi {
  UnsplashPhotosApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseUrlUnsplash = 'api.unsplash.com';

  Future<Photo> getPhoto(String query) async {
    final photoRequest = Uri.https(
      _baseUrlUnsplash,
      '/photos/random',
      {
        'count': '1',
        'query': query,
        'orientation': 'portrait',
        'client_id': dotenv.env['CLIENT_ID']
      },
    );

    final photoResponse = await _httpClient.get(photoRequest);

    if (photoResponse.statusCode != 200) {
      throw PhotoRequestFailure();
    }

    // Unsplash API return json format like so
    // [{...}]
    // we need to parse it to List like data.
    final photoJson = jsonDecode(photoResponse.body) as List;

    if (photoJson.isEmpty) throw PhotoRequestFailure();

    return Photo.fromJson(photoJson.first as Map<String, dynamic>);
  }
}
