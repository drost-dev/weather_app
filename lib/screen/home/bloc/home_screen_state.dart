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
  HomeScreenLoaded({required this.formattedDate});
  final String formattedDate;
  
  @override
  List<Object> get props => [formattedDate];
}

class HomeScreenLoadingError extends HomeScreenState {
  HomeScreenLoadingError();
  
  @override
  List<Object> get props => [];
}