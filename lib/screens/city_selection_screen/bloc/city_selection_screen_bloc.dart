import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'package:weather_app/models/geocoder_data.dart';
import 'package:weather_app/repository/weather_forecast/weater_forecast_repository.dart';

part 'city_selection_screen_event.dart';
part 'city_selection_screen_state.dart';

class CitySelectScreenBloc
    extends Bloc<CitySelectScreenEvent, CitySelectScreenState> {
  CitySelectScreenBloc() : super(CitySelectScreenInitializing()) {
    on<CitySelectScreenLoad>(_load);
    on<CitySelectScreenSearchCity>(_searchCity);
  }

  FutureOr<void> _load(CitySelectScreenLoad event, emit) async {
    emit(CitySelectScreenLoading());
    final prefs = await SharedPreferences.getInstance();

    if (event.result != null) {
      //выбран город

      prefs.setDouble('lat', event.result!.latitude!);
      prefs.setDouble('lon', event.result!.longitude!);
      prefs.setString('cityName', event.result!.name!);

      emit(CitySelectScreenLoaded(selectedCityName: event.result!.name!),);
    } else {
      //первая загрузка/ничего не найдено/пустой ввод
      emit(CitySelectScreenLoaded(selectedCityName: prefs.containsKey('cityName') ? prefs.getString('cityName')! : "Not selected"));
    }
  }

  FutureOr<void> _searchCity(CitySelectScreenSearchCity event, emit) async {
    emit(CitySelectScreenReloading());
    String city;

    if (!RegExp(r'[a-zA-Z]').hasMatch(event.q))
    {
      final translator = GoogleTranslator();
      var translatedQuery = await translator.translate(event.q, to: "en");
      city = translatedQuery.text;
    } else {
      city = event.q;
    }

    final prefs = await SharedPreferences.getInstance();
    var jsonResults =
        await WeatherCastRepository.getCoordinatesApiData(city);
    GeocoderData data = GeocoderData.fromJson(jsonResults);

    prefs.setDouble('lat', data.results![0].latitude!);
    prefs.setDouble('lon', data.results![0].longitude!);
    prefs.setString('cityName', data.results![0].name!);

    emit(CitySelectScreenLoaded(
        selectedCityName: prefs.getString('cityName')!, results: data.results));
  }
}
