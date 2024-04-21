import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/city_selection_screen/bloc/city_selection_screen_bloc.dart';
import 'package:weather_app/screens/home/home_screen.dart';

@RoutePage()
class CitySelectionScreen extends StatefulWidget {
  const CitySelectionScreen({super.key, this.firstLaunch = false});
  final bool firstLaunch;

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  String query = "";
  final _citySelectionScreenBloc = CitySelectScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    _citySelectionScreenBloc.add(CitySelectScreenLoad());
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder(
        bloc: _citySelectionScreenBloc,
        builder: (context, state) {
          if (state is CitySelectScreenLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.selectedCityName,
                        style: theme.textTheme.displayLarge,
                      ),
                      TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z]'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (query != "") {
                            _citySelectionScreenBloc
                                .add(CitySelectScreenSearchCity(q: query));
                          }
                        },
                        child: const Text('Search'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          var pos = await _getPosition();
                          var placemark = await placemarkFromCoordinates(
                            pos.latitude,
                            pos.longitude,
                          );
                          _citySelectionScreenBloc.add(
                              CitySelectScreenSearchCity(
                                  q: placemark[0].locality!));
                        },
                        child: const Text('Use my GPS location'),
                      ),
                    ],
                  ),
                  state.results == null
                      ? const Text('Nothing found.')
                      : SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: ListView.builder(
                            itemCount: state.results!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.results![index].name!,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _citySelectionScreenBloc.add(
                                      CitySelectScreenLoad(
                                          result: state.results![index]));
                                  
                                  AutoRouter.of(context).maybePop();
                                },
                              );
                            },
                          ),
                        ),
                  widget.firstLaunch
                      ? ElevatedButton(
                          onPressed: () {
                            if (state.selectedCityName != "Not selected") {
                              AutoRouter.of(context).replaceNamed('/');
                            }
                          },
                          child: const Text('Next'),
                        )
                      : const SizedBox(
                          width: 1,
                          height: 1,
                        ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
