part of 'home_screen_bloc.dart';

abstract class HomeScreenState extends Equatable {}

class HomeScreenInitializing extends HomeScreenState {
  HomeScreenInitializing();

  @override
  List<Object> get props => [];
}

class HomeScreenLoading extends HomeScreenState {
  HomeScreenLoading();
  
  @override
  List<Object> get props => [];
}

class HomeScreenFirstLoaded extends HomeScreenState {
  HomeScreenFirstLoaded();
  
  @override
  List<Object> get props => [];
}

class HomeScreenLoaded extends HomeScreenState {
  HomeScreenLoaded({required this.nowForecast, required this.weatherData});
  final Forecast nowForecast;
  final WeatherForecastData weatherData;
  
  
  @override
  List<Object> get props => [nowForecast, weatherData];
}

class HomeScreenLoadedHour extends HomeScreenState {
  HomeScreenLoadedHour({required this.hourForecast, required this.weatherData});
  final Forecast hourForecast;
  final WeatherForecastData weatherData;
  
  
  @override
  List<Object> get props => [hourForecast, weatherData];
}

class HomeScreenLoadingError extends HomeScreenState {
  HomeScreenLoadingError(this.error);
  final error;
  
  @override
  List<Object> get props => [error];
}