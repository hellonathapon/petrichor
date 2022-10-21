import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:petrichor/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart'
    show
        WeatherRepository; // Target only WeatherRepository itself, not Weather Model in Repository.
import 'package:petrichor/weather/weather.dart';

part 'weather_cubit.g.dart';
part 'weather_state.dart';

class WeatherCubit extends HydratedCubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;

    // Change WeatherState status to loading before fetching WeatherRepository API(s).
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      // Instantiate Weather.fromRepository constructor from API provided by _weatherRepository instance.
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(city),
      );

      // Get currently WeatherState TempertureUnits
      // and change the value fetched from API accordingly.
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    // Can't refresh if WeatherState never initially fetch.
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.empty) return;

    // Refresh the weather by getting city name from current state.
    try {
      final weather = Weather.fromRepository(
        await _weatherRepository.getWeather(state.weather.location),
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.value.toFahrenheit()
          : weather.temperature.value;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    } on Exception {
      // If an error occurs trying refreshing just simply emit the old state
      emit(state);
    }
  }

  void toggleUnits() {
    // Get current TemperatureUnits by calling on extension of TemperatureUnits.
    final units = state.temperatureUnits.isFahrenheit
        ? TemperatureUnits.celsius
        : TemperatureUnits.fahrenheit;

    // User can only toggle the label of Unit if the WeatherState has no Weather data.
    if (!state.status.isSuccess) {
      emit(state.copyWith(temperatureUnits: units));
      return;
    }

    final weather = state.weather;
    // Only when Weather exists
    if (weather != Weather.empty) {
      final temperature = weather.temperature;

      // units is TemperatureUnits label of WeatherState
      // value is Temperature of Weather which nested as weather in WeatherState
      // We have toCelsius and toFahrenheit on Double to parse between these 2 units
      final value = units.isCelsius
          ? temperature.value.toCelsius()
          : temperature.value.toFahrenheit();
      emit(
        state.copyWith(
          temperatureUnits: units,
          weather: weather.copyWith(temperature: Temperature(value: value)),
        ),
      );
    }
  }

  @override
  WeatherState fromJson(Map<String, dynamic> json) =>
      WeatherState.fromJson(json);

  @override
  Map<String, dynamic> toJson(WeatherState state) => state.toJson();
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}
