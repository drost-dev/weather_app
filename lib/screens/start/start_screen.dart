import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/router/router.dart';

@RoutePage()
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primaryContainer,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.all(75),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/weather.png',
                    color: theme.colorScheme.primary,
                  ),
                  Text(
                    'Weather',
                    style: theme.textTheme.headlineLarge!
                        .apply(color: theme.colorScheme.primary),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('firstLaunch', false);
                AutoRouter.of(context).replace(CitySelectionRoute(firstLaunch: true));
              },
              style: TextButton.styleFrom(
                backgroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: BorderSide(color: theme.colorScheme.primary, width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                child: Text(
                  'Continue',
                  style: theme.textTheme.labelLarge!
                      .apply(color: theme.colorScheme.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
