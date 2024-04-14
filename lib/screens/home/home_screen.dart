import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screens/home/bloc/home_screen_bloc.dart';
import 'package:weather_app/screens/home/widgets/hour_card_list.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeScreenBloc = HomeScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    _homeScreenBloc.add(HomeScreenLoad());
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
                      value: '123',
                      child: Text('1'),
                    ),
                    PopupMenuItem(
                      value: 'sdgusg',
                      child: Text('2'),
                    ),
                    PopupMenuItem(
                      value: 'test3',
                      child: Text('3'),
                    ),
                  ];
                },
                onSelected: (value) {
                  print(value);
                },
              ),
            ],
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            centerTitle: true,
            title: GestureDetector(
              child: const Text(
                "City",
              ),
            ),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          body: BlocBuilder(
            bloc: _homeScreenBloc,
            builder: (context, state) {
              if (state is HomeScreenFirstLoaded) {
                // первый заход в приложение, приветствие
                AutoRouter.of(context).replaceNamed('/start');
                return const Placeholder();
              } else if (state is HomeScreenLoaded) {
                // обыденный запуск приложения
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.nowForecast.formattedNowTime,
                            style: theme.textTheme.headlineMedium!
                                .apply(fontSizeFactor: 1.8),
                          ),
                          Text(
                            state.nowForecast.formattedNowDate,
                            style: theme.textTheme.titleLarge!
                                .apply(fontWeightDelta: -10),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Sunrise:',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                state.nowForecast.sunriseTime,
                                style: theme.textTheme.titleMedium!
                                    .apply(fontWeightDelta: 200),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.nowForecast.temp,
                                style: theme.textTheme.headlineLarge,
                              ),
                              Text(
                                "Feels like: ${state.nowForecast.feelsLikeTemp}",
                                style: theme.textTheme.displayMedium!.apply(fontSizeFactor: 0.4),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Sunset:',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                state.nowForecast.sunsetTime,
                                style: theme.textTheme.titleMedium!
                                    .apply(fontWeightDelta: 200),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageIcon(
                            NetworkImage(
                              state.nowForecast.weatherIcon,
                            ),
                            size: 100,
                          ),
                          Text(
                            state.nowForecast.weatherDescription,
                            style: theme.textTheme.titleLarge,
                          ),
                          Text(
                            'Wind: ${state.nowForecast.windSpeed}, ${state.nowForecast.windDirection}',
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                      HourCardList(weatherData: state.weatherData),
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.colorScheme.onSecondary.withOpacity(0.8),
            onPressed: () {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
