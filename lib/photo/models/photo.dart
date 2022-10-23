import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:photo_repository/photo_repository.dart' as photo_repository;

part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable {
  const Photo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.networkFullUrl,
    required this.networkRawUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  factory Photo.fromRepository(photo_repository.Photo photo) {
    return Photo(
        id: photo.id,
        firstName: photo.firstName,
        lastName: photo.lastName,
        networkFullUrl: photo.fullUrl,
        networkRawUrl: photo.rawUrl);
  }

  final String id;
  final String firstName;
  final String lastName;
  final String networkFullUrl;
  final String networkRawUrl;

  // For instantiate a empty Photo
  // use case : cubit initial state
  static const empty = Photo(
    id: '--',
    firstName: '--',
    lastName: '--',
    networkFullUrl:
        'https://images.unsplash.com/photo-1592856908193-b9934576cf3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=649&q=80',
    networkRawUrl:
        'https://images.unsplash.com/photo-1592856908193-b9934576cf3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=649&q=80',
  );

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  // For updating specific values of the instance
  Photo copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? networkFullUrl,
    String? networkRawUrl,
  }) {
    return Photo(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      networkFullUrl: networkFullUrl ?? this.networkFullUrl,
      networkRawUrl: networkRawUrl ?? this.networkRawUrl,
    );
  }

  @override
  List<Object> get props =>
      [id, firstName, lastName, networkFullUrl, networkRawUrl];
}
