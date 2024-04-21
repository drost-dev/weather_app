part of 'city_selection_screen_bloc.dart';

abstract class CitySelectScreenEvent extends Equatable {}

class CitySelectScreenInit extends CitySelectScreenEvent {
  CitySelectScreenInit();

  @override
  List<Object> get props => [];
}

class CitySelectScreenLoad extends CitySelectScreenEvent {
  CitySelectScreenLoad({this.result});
  final Results? result;

  @override
  List<Object?> get props => [result];
}

class CitySelectScreenSearchCity extends CitySelectScreenEvent {
  CitySelectScreenSearchCity({required this.q});
  final String q;

  @override
  List<Object> get props => [q];
}