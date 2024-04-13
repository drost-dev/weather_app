part of 'home_screen_bloc.dart';

abstract class HomeScreenState {}

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
  String formattedDate;
  
  @override
  List<Object> get props => [];
}

class HomeScreenLoadingError extends HomeScreenState {
  HomeScreenLoadingError();
  
  @override
  List<Object> get props => [];
}