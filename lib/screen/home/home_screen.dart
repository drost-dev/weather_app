import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/screen/home/bloc/home_screen_bloc.dart';

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
              "ГОРОД",
            )),
          ),
          backgroundColor: Colors.white.withOpacity(0.2),
          body: BlocBuilder(
            bloc: _homeScreenBloc,
            builder: (context, state) {
              if (state is HomeScreenLoaded && state.firstLaunch) {
                AutoRouter.of(context).replaceNamed('/start');
                return const Placeholder();
              } else if (state is HomeScreenLoaded && !state.firstLaunch) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('test text'),
                    ],
                  ),
                );
              } else if (state is HomeScreenInitializing) {
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'aaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                    ),
                  ],
                ));
              } else {
                return Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
