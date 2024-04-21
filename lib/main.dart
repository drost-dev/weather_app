import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/router/router.dart';
import 'package:weather_app/themes/light_theme.dart';

void main() async {
  runApp(const WeatherApp());

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('firstLaunch'))
  {
    prefs.setBool('firstLaunch', true);
  }

  if (!prefs.containsKey('lat'))
  {
    prefs.setDouble('lat', 0);
  }

  if (!prefs.containsKey('lon'))
  {
    prefs.setDouble('lon', 0);
  }
  
  if (!prefs.containsKey('cityName'))
  {
    prefs.setString('cityName', "Not selected");
  }
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _router = AppRouter();
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router.config(),
      title: 'Weather',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}