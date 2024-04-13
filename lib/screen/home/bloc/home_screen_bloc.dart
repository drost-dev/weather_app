import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitializing()) {
    on<HomeScreenLoad>(_load);
  }

  FutureOr<void> _load(HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('firstLaunch')!)
    {
      emit(HomeScreenFirstLoaded());
    }
    else
    {
      String formattedDate = DateFormat('EEEE, d MMM, H:mm').format(DateTime.now());
      emit(HomeScreenLoaded(formattedDate: formattedDate));
    } 
  }
}