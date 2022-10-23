import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrichor/photo/cubit/photo_cubit.dart';
import 'package:petrichor/weather/weather.dart';
import 'package:petrichor/settings/settings.dart';
import 'package:petrichor/search/search.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WeatherView();
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Petrichor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsScreen.route(
                  context.read<WeatherCubit>(),
                ),
              );
            },
          ),
        ],
      ),
      // body is devided into 2 parts, Background image Widget and Weather Data Widget by using Stack.
      body: Stack(
        children: [
          // for background image to display, we select it from PhotoCubit state
          BlocSelector<PhotoCubit, PhotoState, PhotoState>(
            selector: (state) {
              return state;
            },
            builder: (context, state) {
              return ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: FadeInImage(
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: AssetImage(state.fallbackPhoto),
                  image: NetworkImage(state.networkPhoto.networkRawUrl),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          // for weather data to populated, we select it from WeatherCubit state
          BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              // PhotoCubit actually depends on Weather Condition
              // here we listen on WeatherCondition changes from initial state to whatever conditions
              // make use of that condition to retrieve an new photo.
              if (!state.weather.condition.isUnknown) {
                context.read<PhotoCubit>().updatePhoto(state.weather.condition);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return WeatherPopulated(
                    weather: state.weather,
                    units: state.temperatureUnits,
                    onRefresh: () {
                      return context.read<WeatherCubit>().refreshWeather();
                    },
                  );
                case WeatherStatus.failure:
                  return const WeatherError();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchScreen.route());
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
