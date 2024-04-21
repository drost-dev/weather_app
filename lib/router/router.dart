import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_selection_screen/city_selection_screen.dart';
import 'package:weather_app/screens/home/home_screen.dart';
import 'package:weather_app/screens/start/start_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: StartRoute.page,
          path: '/start',
        ),
        AutoRoute(
          page: CitySelectionRoute.page,
          path: '/citySelect'
        )
      ];
}
