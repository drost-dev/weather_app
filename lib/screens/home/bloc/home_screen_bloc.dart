import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/weather_forecast_data.dart';
import 'package:weather_app/models/wmo_codes.dart';
import 'package:weather_app/repository/weather_forecast/weater_forecast_repository.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitializing()) {
    on<HomeScreenLoad>(_load);
    on<HomeScreenChooseHour>(_loadHour);
  }

  FutureOr<void> _load(HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoading());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getBool('firstLaunch') == null) {
        emit(HomeScreenFirstLoaded());
      } else {
        /*final geoApiData =
            await WeatherCastRepository.getCoordinatesApiData(prefs.getString('cityName')!);
        final geoData = GeocoderData.fromJson(geoApiData);
        final weatherApiData =
            await WeatherCastRepository.getWeatherForecastApiData(
                geoData.results![0].latitude!, geoData.results![0].longitude!);
        final weatherData = WeatherForecastData.fromJson(weatherApiData);*/

        final weatherApiData =
            await WeatherCastRepository.getWeatherForecastApiData(
                prefs.getDouble('lat')!, prefs.getDouble('lon')!);
        final weatherData = WeatherForecastData.fromJson(weatherApiData);

        emit(HomeScreenLoaded(
          weatherData: weatherData,
          nowForecast: _getForecast(weatherData),
        ));
      }
    } catch (e, st) {
      emit(HomeScreenLoadingError(e));
      print(st);
      print(e.toString());
    }
  }

  FutureOr<void> _loadHour(HomeScreenChooseHour event, Emitter<HomeScreenState> emit) async {
    emit(
      HomeScreenLoadedHour(
        weatherData: event.weatherData,
        hourForecast: _getForecast(event.weatherData, hour: event.hour),
      ),
    );
  }

  String _getWindDirection(WeatherForecastData weatherData, {int hour = -1}) {
    final int windDir;
    if (hour == -1) {
      windDir = weatherData.current!.windDirection10m!;
    } else {
      windDir = weatherData.hourly!.windDirection10m![hour];
    }

    String windDirection = "";
    if (windDir >= 0 && windDir < 45) {
      windDirection = "N";
    } else if (windDir >= 45 && windDir < 90) {
      windDirection = "NE";
    } else if (windDir >= 90 && windDir < 135) {
      windDirection = "E";
    } else if (windDir >= 135 && windDir < 180) {
      windDirection = "SE";
    } else if (windDir >= 180 && windDir < 225) {
      windDirection = "S";
    } else if (windDir >= 225 && windDir < 270) {
      windDirection = "SW";
    } else if (windDir >= 270 && windDir < 315) {
      windDirection = "W";
    } else if (windDir >= 315 && windDir <= 360) {
      windDirection = "NW";
    }

    return windDirection;
    //return "$windDirection${weatherData.currentUnits!.windDirection10m}";
  }

  Forecast _getForecast(WeatherForecastData weatherData, {int hour = -1}) {
    String formattedTime;
    String formattedDate;
    String temp;
    String feelsLikeTemp;
    String sunriseTime;
    String sunsetTime;
    String weatherDescription;
    String weatherIcon;
    String windSpeed;
    String windDirection;

    if (hour == -1) {
      formattedTime = DateFormat('H:mm').format(DateTime.now());
      formattedDate = DateFormat('E, d MMM').format(DateTime.now());
      temp =
          "${weatherData.current!.temperature2m!.round()} ${weatherData.currentUnits!.temperature2m}";
      feelsLikeTemp =
          "${weatherData.current!.apparentTemperature!.round()} ${weatherData.currentUnits!.apparentTemperature}";
      sunriseTime = DateFormat('H:mm')
          .format(DateTime.parse(weatherData.daily!.sunrise![0]));
      sunsetTime = DateFormat('H:mm')
          .format(DateTime.parse(weatherData.daily!.sunset![0]));
      weatherDescription = wmoCodes["${weatherData.current!.weatherCode!}"]![
          "night"]!["description"]!;
      weatherIcon =
          wmoCodes["${weatherData.current!.weatherCode!}"]!["night"]!["image"]!;
      windSpeed =
          "${weatherData.current!.windSpeed10m!.round()} ${weatherData.currentUnits!.windSpeed10m}";
      windDirection = _getWindDirection(weatherData);
    } else {
      var nowDate = DateTime.now();

      var hourDate =
          DateTime(nowDate.year, nowDate.month, nowDate.day, hour, hour == nowDate.hour ? nowDate.minute : 0, 0);

      formattedTime = DateFormat('H:mm').format(hourDate);
      formattedDate = DateFormat('E, d MMM').format(DateTime.now());
      temp =
          "${weatherData.hourly!.temperature2m![hour].round()} ${weatherData.hourlyUnits!.temperature2m}"; //мб ошибка будет
      feelsLikeTemp =
          "${weatherData.hourly!.apparentTemperature![hour].round()} ${weatherData.hourlyUnits!.apparentTemperature}";

      sunriseTime = DateFormat('H:mm')
          .format(DateTime.parse(weatherData.daily!.sunrise![0]));
      sunsetTime = DateFormat('H:mm')
          .format(DateTime.parse(weatherData.daily!.sunset![0]));

      weatherDescription =
          wmoCodes["${weatherData.hourly!.weatherCode![hour]}"]!["night"]![
              "description"]!;
      weatherIcon = wmoCodes["${weatherData.hourly!.weatherCode![hour]}"]![
          "night"]!["image"]!;
      windSpeed =
          "${weatherData.hourly!.windSpeed10m![hour].round()} ${weatherData.hourlyUnits!.windSpeed10m}";
      windDirection = _getWindDirection(weatherData);
    }

    return Forecast(
      formattedTime: formattedTime,
      formattedDate: formattedDate,
      temp: temp,
      feelsLikeTemp: feelsLikeTemp,
      sunriseTime: sunriseTime,
      sunsetTime: sunsetTime,
      weatherDescription: weatherDescription,
      weatherIcon: weatherIcon,
      windSpeed: windSpeed,
      windDirection: windDirection,
    );
  }
}
