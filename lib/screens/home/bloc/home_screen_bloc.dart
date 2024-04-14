import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/geocoder_data.dart';
import 'package:weather_app/models/now_forecast.dart';
import 'package:weather_app/models/weather_forecast_data.dart';
import 'package:weather_app/models/wmo_codes.dart';
import 'package:weather_app/repository/weather_forecast/weater_forecast_repository.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitializing()) {
    on<HomeScreenLoad>(_load);
  }

  FutureOr<void> _load(HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoading());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.getBool('firstLaunch')!) {
        emit(HomeScreenFirstLoaded());
      } else {
        final geoApiData =
            await WeatherCastRepository.getCoordinatesApiData("Tomsk");
        final geoData = GeocoderData.fromJson(geoApiData);
        final weatherApiData =
            await WeatherCastRepository.getWeatherForecastApiData(
                geoData.results![0].latitude!, geoData.results![0].longitude!);
        final weatherData = WeatherForecastData.fromJson(weatherApiData);

        String windDirection = "";

        if (weatherData.current!.windDirection10m! >= 0 && weatherData.current!.windDirection10m! < 45)
        {
          windDirection = "N";
        } else if (weatherData.current!.windDirection10m! >= 45 && weatherData.current!.windDirection10m! < 90)
        {
          windDirection = "NE";
        } else if (weatherData.current!.windDirection10m! >= 90 && weatherData.current!.windDirection10m! < 135)
        {
          windDirection = "E";
        } else if (weatherData.current!.windDirection10m! >= 135 && weatherData.current!.windDirection10m! < 180)
        {
          windDirection = "SE";
        } else if (weatherData.current!.windDirection10m! >= 180 && weatherData.current!.windDirection10m! < 225)
        {
          windDirection = "S";
        } else if (weatherData.current!.windDirection10m! >= 225 && weatherData.current!.windDirection10m! < 270)
        {
          windDirection = "SW";
        } else if (weatherData.current!.windDirection10m! >= 270 && weatherData.current!.windDirection10m! < 315)
        {
          windDirection = "W";
        } else if (weatherData.current!.windDirection10m! >= 315 && weatherData.current!.windDirection10m! <= 360)
        {
          windDirection = "NW";
        }

        String formattedNowTime = DateFormat('H:mm').format(DateTime.now());
        String formattedNowDate = DateFormat('E, d MMM').format(DateTime.now());

        emit(
          HomeScreenLoaded(
            weatherData: weatherData,
            nowForecast: NowForecast(
              formattedNowTime: formattedNowTime,
              formattedNowDate: formattedNowDate,
              temp: "${weatherData.current!.temperature2m!.round()} ${weatherData.currentUnits!.temperature2m}",
              feelsLikeTemp: "${weatherData.current!.apparentTemperature!.round()} ${weatherData.currentUnits!.apparentTemperature}",
              sunriseTime: DateFormat('H:mm')
                  .format(DateTime.parse(weatherData.daily!.sunrise![0])),
              sunsetTime: DateFormat('H:mm')
                  .format(DateTime.parse(weatherData.daily!.sunset![0])),
              weatherDescription: wmoCodes[
                      "${weatherData.current!.weatherCode!}"]![
                  "night"]!["description"]!,
              weatherIcon: wmoCodes[
                      "${weatherData.current!.weatherCode!}"]![
                  "night"]!["image"]!,
              windSpeed: "${weatherData.current!.windSpeed10m!.round()} ${weatherData.currentUnits!.windSpeed10m}",
              windDirection: "$windDirection${weatherData.currentUnits!.windDirection10m}"
            ),
          ),
        );
      }
    } catch (e, st) {
      emit(HomeScreenLoadingError(e));
      print(st);
      print(e.toString());
    }
  }
}
