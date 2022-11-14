import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants/app_sizedboxes.dart';

import '../../providers/weather_provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({
    super.key,
    required this.toggleValue,
  });
  final bool toggleValue;
  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      weatherProvider.getWeatherData(toggleValue);
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => weatherProvider.logOutDialougue(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<WeatherProvider>(builder: (context, values, _) {
            return values.dataGetting == true
                ? const Center(child: CircularProgressIndicator())
                : values.weatherData == null
                    ? Center(
                        child: IconButton(
                          onPressed: () => values.getWeatherData(toggleValue),
                          icon: const Icon(
                            Icons.refresh,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          AppsizedBoxes.sizedBoxH40,
                          const Icon(
                            Icons.sunny,
                            size: 64,
                            color: Colors.orange,
                          ),
                          AppsizedBoxes.sizedboxH10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${values.convertedTemp}',
                                style: const TextStyle(
                                  fontSize: 46,
                                ),
                              ),
                              Text(
                                toggleValue == true ? '°C' : '°F',
                                style: const TextStyle(fontSize: 40),
                              )
                            ],
                          ),
                          AppsizedBoxes.sizedBoxH20,
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: Column(
                              children: [
                                Text(
                                  'Weather is ${values.weatherData?.daily[0].weatherType[0].description}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                AppsizedBoxes.sizedBoxH20,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Humidity:${values.weatherData?.daily[0].humidity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Wind Speed:${values.weatherData?.daily[0].windSpeed}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
          }),
        ),
      ),
    );
  }
}
