import 'package:equatable/equatable.dart';

class Forecast extends Equatable {
  final String formattedTime;
  final String formattedDate;
  final String temp;
  final String feelsLikeTemp;
  final String sunriseTime;
  final String sunsetTime;
  final String weatherDescription;
  final String weatherIcon;
  final String windSpeed;
  final String windDirection;

  const Forecast({
    required this.formattedTime,
    required this.formattedDate,
    required this.temp,
    required this.feelsLikeTemp,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.weatherDescription,
    required this.weatherIcon,
    required this.windSpeed,
    required this.windDirection,
  });

  @override
  List<Object> get props => [
        formattedTime,
        formattedDate,
        temp,
        feelsLikeTemp,
        sunriseTime,
        sunsetTime,
        weatherDescription,
        weatherIcon,
        windSpeed,
        windDirection,
      ];
}
