import 'dart:async';
import 'package:unsplash_photos_api/unsplash_photos_api.dart' hide Photo;
import 'package:photo_repository/photo_repository.dart';

class PhotoRepository {
  PhotoRepository({UnsplashPhotosApi? unsplashPhotosApi})
      : _unsplashPhotosApi = unsplashPhotosApi ?? UnsplashPhotosApi();

  final UnsplashPhotosApi _unsplashPhotosApi;

  Future<Photo> getPhoto(String weatherCondition) async {
    final photo = await _unsplashPhotosApi.getPhoto(weatherCondition);

    return Photo(
      id: photo.id,
      firstName: photo.user.firstName,
      lastName: photo.user.lastName,
      rawUrl: photo.urls.raw,
      fullUrl: photo.urls.full,
    );
  }
}
