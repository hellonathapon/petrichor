import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:open_meteo_api/open_meteo_api.dart';

// Exceptions
class LocationRequestFailure implements Exception {}

class LocationNotFoundFailure implements Exception {}

class WeatherRequestFailure implements Exception {}

class WeatherNotFoundFailure implements Exception {}

/// {@template open_meteo_api_client}
/// Dart API Client which wraps the [Open Meteo API](https://open-meteo.com).
/// {@endtemplate}
class OpenMeteoApiClient {
  // Basically, user/dev is free to use any http client on this Api
  // so they could opt to use their own http by specify the client
  // otherwise we will make use of default Dart http package.
  /// {@macro open_meteo_api_client}
  OpenMeteoApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  static const _baseUrlGeoCoding = 'geocoding-api.open-meteo.com';
  static const _baseUrlWeather = 'api.open-meteo.com';

  Future<Location> locationSearch(String query) async {
    final locationRequest = Uri.https(
      _baseUrlGeoCoding,
      '/v1/search',
      {'name': query, 'count': '1'},
    );

    final locationResponse = await _httpClient.get(locationRequest);

    if (locationResponse.statusCode != 200) {
      throw LocationRequestFailure();
    }

    // Location API return json format like so
    // {"results": [...]}
    // and Dart sees it as a String type so we need to parse it to Map like data.
    final locationJson = jsonDecode(locationResponse.body) as Map;

    if (!locationJson.containsKey('results')) throw LocationNotFoundFailure();

    // Simply access to 'results' key, and make it List type like data.
    final results = locationJson['results'] as List;

    if (results.isEmpty) throw LocationNotFoundFailure();

    // Finally, instantiate Location from JSON and return it.
    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  Future<Weather> getWeather(
      {required double latitude, required double longitude}) async {
    final weatherRequest = Uri.https(
      _baseUrlWeather,
      'v1/forecast',
      {
        'latitude': '$latitude',
        'longitude': '$longitude',
        'current_weather': 'true'
      },
    );

    final weatherResponse = await _httpClient.get(weatherRequest);

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    // Location API return json format like so
    // {"current_weather": {...}}
    final weatherJson =
        jsonDecode(weatherResponse.body) as Map<String, dynamic>;

    if (!weatherJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    // Since this API returns data as nested Map
    // here we access to its nested one and make it like a Map type data again.
    final currentWeather =
        weatherJson['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(currentWeather);
  }
}
