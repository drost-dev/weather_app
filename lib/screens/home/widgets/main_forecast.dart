import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast.dart';

class MainForecast extends StatelessWidget {
  const MainForecast({super.key, required this.forecast});
  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              forecast.formattedTime,
              style: theme.textTheme.headlineMedium!.apply(fontSizeFactor: 1.8),
            ),
            Text(
              forecast.formattedDate,
              style: theme.textTheme.titleLarge!.apply(fontWeightDelta: -10),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sunrise:',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  forecast.sunriseTime,
                  style:
                      theme.textTheme.titleMedium!.apply(fontWeightDelta: 200),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  forecast.temp,
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  "Feels like: ${forecast.feelsLikeTemp}",
                  style:
                      theme.textTheme.displayMedium!.apply(fontSizeFactor: 0.4),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sunset:',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  forecast.sunsetTime,
                  style:
                      theme.textTheme.titleMedium!.apply(fontWeightDelta: 200),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageIcon(
              NetworkImage(
                forecast.weatherIcon,
              ),
              size: 100,
            ),
            Text(
              forecast.weatherDescription,
              style: theme.textTheme.titleLarge,
            ),
            Text(
              'Wind: ${forecast.windSpeed}, ${forecast.windDirection}',
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
