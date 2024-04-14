import 'package:auto_route/auto_route.dart';
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
      ];
}
