import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_forecast_data.dart';

class HourCardList extends StatelessWidget {
  const HourCardList({super.key, required this.weatherData});
  final WeatherForecastData weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
      ),
      constraints: const BoxConstraints(
        maxHeight: 200,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
            ),
            constraints: BoxConstraints(maxHeight: 100),
            width: 30,
            child: Text(weatherData.hourly!.temperature2m![index].toString()),
          );
        },
      ),
    );
  }
}
