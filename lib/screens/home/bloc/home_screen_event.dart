part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

class HomeScreenLoad extends HomeScreenEvent {
  HomeScreenLoad();

  @override
  List<Object> get props => [];
}

class HomeScreenChooseHour extends HomeScreenEvent {
  HomeScreenChooseHour({required this.weatherData, required this.hour});
  final WeatherForecastData weatherData;
  final int hour;

  @override
  List<Object> get props => [hour];
}