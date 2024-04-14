import 'package:equatable/equatable.dart';
import 'package:weather_app/models/weather_forecast_data.dart';

class NowForecast extends Equatable {
  final String formattedNowTime;
  final String formattedNowDate;
  final String temp;
  final String feelsLikeTemp;
  final String sunriseTime;
  final String sunsetTime;
  final String weatherDescription;
  final String weatherIcon;
  final String windSpeed;
  final String windDirection;

  const NowForecast({
    required this.formattedNowTime,
    required this.formattedNowDate,
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
        formattedNowTime,
        formattedNowDate,
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
