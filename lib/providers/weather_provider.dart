import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model/weather_model.dart';
import '../service/weather_service/weather_service.dart';
import '../views/login/login_screen.dart';
import '../views/weather/widgets/logout_dialougue.dart';

class WeatherProvider with ChangeNotifier {
  WeatherData? weatherData;
  bool dataGetting = false;
  dynamic convertedTemp;

  void logOutDialougue(context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return const LogOutDialougue();
      },
    );
  }

  void logOut(context) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false);
  }

  Future<void> getWeatherData(bool toggleValue) async {
    dataGetting = true;
    notifyListeners();
    await WeatherServices().getWeatherDetails().then((value) {
      weatherData = value;
      dataGetting = false;
      notifyListeners();
      convertTemp(toggleValue);
    });
  }

  void convertTemp(bool toggleValue) {
    if (toggleValue == false) {
      convertedTemp =
          (weatherData?.daily[0].temp.day as dynamic) * (9 / 5) + 32 as dynamic;
      notifyListeners();
    } else {
      convertedTemp = weatherData?.daily[0].temp.day;
      notifyListeners();
    }
  }
}
