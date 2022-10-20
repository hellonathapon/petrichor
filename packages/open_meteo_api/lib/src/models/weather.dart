import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Weather({
    required this.temperature,
    required this.weatherCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  final double temperature;
  // api response json key is 'weathercode'
  // we want our variable to compatible with it.
  @JsonKey(name: 'weathercode')
  final double weatherCode;
}
