import 'package:dio/dio.dart';

class WeatherCastRepository {
  static Future<Map<String, dynamic>> getCoordinatesApiData(String query) async {
    final dio = Dio();
    final resp = await dio.get('https://geocoding-api.open-meteo.com/v1/search?name=$query&count=1&language=en&format=json');
    Map<String, dynamic> apiData = resp.data;
    return apiData;
  }

  static Future<Map<String, dynamic>> getWeatherForecastApiData(double lat, double lon) async {
    final dio = Dio();
    final resp = await dio.get('https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,apparent_temperature,weather_code,wind_speed_10m,wind_direction_10m&hourly=temperature_2m,apparent_temperature,precipitation_probability,weather_code,wind_speed_10m,wind_direction_10m&daily=sunrise,sunset&timezone=auto&forecast_days=1');
    Map<String, dynamic> apiData = resp.data;
    return apiData;
  }
}
