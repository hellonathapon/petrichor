import 'package:json_annotation/json_annotation.dart';

part 'url.g.dart';

@JsonSerializable()
class Url {
  Url({required this.raw, required this.full});

  factory Url.fromJson(Map<String, dynamic> json) => _$UrlFromJson(json);

  final String raw;
  final String full;
}
