part of 'city_selection_screen_bloc.dart';

abstract class CitySelectScreenState extends Equatable {}

class CitySelectScreenInitializing extends CitySelectScreenState {
  CitySelectScreenInitializing();

  @override
  List<Object> get props => [];
}

class CitySelectScreenLoading extends CitySelectScreenState {
  CitySelectScreenLoading();

  @override
  List<Object> get props => [];
}

class CitySelectScreenReloading extends CitySelectScreenState {
  CitySelectScreenReloading();

  @override
  List<Object> get props => [];
}

class CitySelectScreenLoaded extends CitySelectScreenState {
  CitySelectScreenLoaded({required this.selectedCityName, this.results});
  final String selectedCityName;
  final List<Results>? results;

  @override
  List<Object?> get props => [selectedCityName, results];
}