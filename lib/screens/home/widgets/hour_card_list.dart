import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_forecast_data.dart';
import 'package:weather_app/models/wmo_codes.dart';
import 'package:weather_app/screens/home/bloc/home_screen_bloc.dart';

class HourCardList extends StatefulWidget {
  const HourCardList({super.key, required this.weatherData, required this.bloc, required this.initHour});
  final WeatherForecastData weatherData;
  final HomeScreenBloc bloc;
  final int initHour;

  @override
  State<HourCardList> createState() => _HourCardListState();
}

class _HourCardListState extends State<HourCardList> {
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    selectedIndex = widget.initHour;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var nowDate = DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 150,
      child: ListView.builder(
        controller: ScrollController(
          initialScrollOffset: 90*widget.initHour.toDouble(),
          keepScrollOffset: true,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: 24,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(
                () {
                  selectedIndex = index;
                  widget.bloc.add(HomeScreenChooseHour(weatherData: widget.weatherData, hour: selectedIndex));
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(-3, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(12),
                color: theme.colorScheme.onPrimary
                    .withOpacity(selectedIndex == index ? 0.3 : 0.15),
              ),
              width: 80,
              child: Column(
                children: [
                  Text(
                    DateFormat('HH:mm').format(DateTime(nowDate.year, nowDate.month, nowDate.day, index, index == nowDate.hour ? nowDate.minute : 0, 0)),
                    style: theme.textTheme.titleMedium,
                  ),
                  Flexible(
                    child: Image.network(
                      wmoCodes[
                              "${widget.weatherData.hourly!.weatherCode![index]}"]![
                          "night"]!["image"]!,
                    ),
                  ),
                  Text(
                    "${widget.weatherData.hourly!.temperature2m![index].round().toString()}${widget.weatherData.hourlyUnits!.temperature2m}",
                    style:
                        theme.textTheme.titleLarge!.apply(fontWeightDelta: 2),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
