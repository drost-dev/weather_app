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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("заглушка"),
      ),
      body: BlocBuilder(
        bloc: _homeScreenBloc,
        builder: (context, state) {
          if (state is HomeScreenLoaded && state.firstLaunch) 
          {
            AutoRouter.of(context).replaceNamed('/start');
            return const Placeholder();
          } 
          else if (state is HomeScreenLoaded && !state.firstLaunch) 
          {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '123',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            );
          } 
          else 
          {
            return Container(
              color: Theme.of(context).colorScheme.primaryContainer,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
