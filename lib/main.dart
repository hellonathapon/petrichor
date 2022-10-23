import 'package:flutter/material.dart';
import 'package:petrichor/app.dart';
import 'package:petrichor/weather_bloc_observer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:photo_repository/photo_repository.dart';
import 'package:weather_repository/weather_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:petrichor/app_hydrated_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  HydratedBloc.storage = MyHydratedStorage();
  Bloc.observer = WeatherBlocObserver();

  runApp(App(
    weatherRepository: WeatherRepository(),
    photoRepository: PhotoRepository(),
  ));
}
