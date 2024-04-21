import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/screens/city_selection_screen/city_selection_screen.dart';
import 'package:weather_app/screens/home/bloc/home_screen_bloc.dart';
import 'package:weather_app/screens/home/widgets/hour_card_list.dart';

import 'widgets/main_forecast.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeScreenBloc = HomeScreenBloc();
  late String cityName = "";

  @override
  void initState() {
    // TODO: implement initState
    _homeScreenBloc.add(HomeScreenLoad());
    _fetchCityName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Image.asset(
            'assets/sky.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 'clear',
                      child: Text('Clear Data'),
                    ),
                    /*PopupMenuItem(
                      value: 'sdgusg',
                      child: Text('2'),
                    ),
                    PopupMenuItem(
                      value: 'test3',
                      child: Text('3'),
                    ),*/
                  ];
                },
                onSelected: (value) async {
                  if (value == 'clear') {
                    var prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                  }
                },
              ),
            ],
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            centerTitle: true,
            title: GestureDetector(
              //TODO: сделать выбор города
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white.withOpacity(0),
                  context: context,
                  builder: (context) {
                    return const CitySelectionScreen();
                  },
                  scrollControlDisabledMaxHeightRatio: 0.9,
                ).whenComplete(() {
                  _homeScreenBloc.add(HomeScreenLoad());
                  _fetchCityName();
                });
              },
              child: Text(
                cityName,
              ),
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          body: RefreshIndicator(
            //TODO: аааааа индикатор перезагрузки сделать
            onRefresh: () async {
              return Future.delayed(const Duration(milliseconds: 500));
            },
            child: BlocBuilder(
              bloc: _homeScreenBloc,
              builder: (context, state) {
                if (state is HomeScreenFirstLoaded) {
                  // первый заход в приложение, приветствие
                  AutoRouter.of(context).replaceNamed('/start');
                  return Container(
                    color: theme.colorScheme.primaryContainer,
                  );
                } else if (state is HomeScreenLoaded) {
                  // обыденный запуск приложения, прогноз на текущее время
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MainForecast(
                          forecast: state.nowForecast,
                        ),
                        HourCardList(
                          weatherData: state.weatherData,
                          bloc: _homeScreenBloc,
                          initHour: DateTime.now().hour,
                        ),
                        const SizedBox(
                          width: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                } else if (state is HomeScreenLoadedHour) {
                  //отображение прогноза на выбранный час
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MainForecast(
                          forecast: state.hourForecast,
                        ),
                        HourCardList(
                          weatherData: state.weatherData,
                          bloc: _homeScreenBloc,
                          initHour: DateTime.now().hour,
                        ),
                        const SizedBox(
                          width: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  );
                } else if (state is HomeScreenInitializing) {
                  // инициализация приложения (можно сделать подобие сплеш скрина)
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Initializing app...',
                        ),
                      ],
                    ),
                  );
                } else if (state is HomeScreenLoading) {
                  // подгрузка инфы
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeScreenLoadingError) {
                  // ошибка в бизнес логике
                  return Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Text(state.error.toString()),
                  );
                } else {
                  // непредвиденный стейт (?)
                  return const Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 50,
                      color: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            mini: true,
            backgroundColor: theme.colorScheme.onSecondary.withOpacity(0.8),
            onPressed: () {
              _homeScreenBloc.add(HomeScreenLoad());
              _fetchCityName();
            },
            tooltip: 'Show Now Forecast',
            child: const Icon(Icons.refresh_outlined),
          ),
        ),
      ],
    );
  }

  Future<void> _fetchCityName() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (prefs.containsKey('cityName')) {
        cityName = prefs.getString('cityName')!;
      } else {
        cityName = "Not selected";
      }
    });
  }
}
