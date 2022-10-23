import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrichor/photo/cubit/photo_cubit.dart';
import 'package:petrichor/weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_repository/photo_repository.dart';
import 'package:weather_repository/weather_repository.dart';

class App extends StatelessWidget {
  const App(
      {super.key,
      required WeatherRepository weatherRepository,
      required PhotoRepository photoRepository})
      : _weatherRepository = weatherRepository,
        _photoRepository = photoRepository;

  final WeatherRepository _weatherRepository;
  final PhotoRepository _photoRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _weatherRepository,
        ),
        RepositoryProvider.value(
          value: _photoRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => WeatherCubit(_weatherRepository),
          ),
          BlocProvider(
            create: (context) => PhotoCubit(_photoRepository),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: color,
        textTheme: GoogleFonts.rajdhaniTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme)
              .apply(bodyColor: Colors.white)
              .headline6,
        ),
      ),
      home: const WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
