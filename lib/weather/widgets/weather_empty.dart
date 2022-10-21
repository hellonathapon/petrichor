import 'package:flutter/material.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        'Please Select a City!',
        style: theme.textTheme.headline5,
      ),
    );
  }
}
