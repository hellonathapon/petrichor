import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// Abstract data layer of photo model and expose it to bloc

part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable {
  const Photo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rawUrl,
    required this.fullUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String rawUrl;
  final String fullUrl;

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  List<Object> get props => [id, firstName, lastName, rawUrl, fullUrl];
}
