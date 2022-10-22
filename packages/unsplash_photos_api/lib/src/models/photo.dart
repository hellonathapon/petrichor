import 'package:json_annotation/json_annotation.dart';
import 'package:unsplash_photos_api/unsplash_photos_api.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  Photo({required this.id, required this.user, required this.urls});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  final String id;
  final User user;
  final Url urls;
}
