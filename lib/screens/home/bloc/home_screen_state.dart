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
  final NowForecast nowForecast;
  final WeatherForecastData weatherData;
  
  
  @override
  List<Object> get props => [nowForecast, weatherData];
}

class HomeScreenLoadingError extends HomeScreenState {
  HomeScreenLoadingError(this.error);
  final error;
  
  @override
  List<Object> get props => [];
}