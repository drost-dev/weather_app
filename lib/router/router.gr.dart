// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CitySelectionRoute.name: (routeData) {
      final args = routeData.argsAs<CitySelectionRouteArgs>(
          orElse: () => const CitySelectionRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CitySelectionScreen(
          key: args.key,
          firstLaunch: args.firstLaunch,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    StartRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const StartScreen(),
      );
    },
  };
}

/// generated route for
/// [CitySelectionScreen]
class CitySelectionRoute extends PageRouteInfo<CitySelectionRouteArgs> {
  CitySelectionRoute({
    Key? key,
    bool firstLaunch = false,
    List<PageRouteInfo>? children,
  }) : super(
          CitySelectionRoute.name,
          args: CitySelectionRouteArgs(
            key: key,
            firstLaunch: firstLaunch,
          ),
          initialChildren: children,
        );

  static const String name = 'CitySelectionRoute';

  static const PageInfo<CitySelectionRouteArgs> page =
      PageInfo<CitySelectionRouteArgs>(name);
}

class CitySelectionRouteArgs {
  const CitySelectionRouteArgs({
    this.key,
    this.firstLaunch = false,
  });

  final Key? key;

  final bool firstLaunch;

  @override
  String toString() {
    return 'CitySelectionRouteArgs{key: $key, firstLaunch: $firstLaunch}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StartScreen]
class StartRoute extends PageRouteInfo<void> {
  const StartRoute({List<PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
