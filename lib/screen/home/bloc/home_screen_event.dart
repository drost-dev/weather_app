part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

class HomeScreenLoad extends HomeScreenEvent {
  HomeScreenLoad();

  @override
  List<Object> get props => [];
}