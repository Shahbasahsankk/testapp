import 'dart:developer';

import 'package:dio/dio.dart';

import '../../constants/app_exceptions.dart';
import '../../models/weather_model/weather_model.dart';

class WeatherServices {
  Future<WeatherData?> getWeatherDetails() async {
    final dio = Dio();
    Map<String, String> headers = {'Accept': 'application/json'};
    try {
      final Response response = await dio.get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=12.9082847623315&lon=77.65197822993314&units=imperial&appid=b143bb707b2ee117e62649b358207d3e',
        options: Options(headers: headers),
      );
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        var jsonAsBody = WeatherData.fromJson(response.data);
        return jsonAsBody;
      } else {
        log('error occured');
      }
    } catch (e) {
      AppExceptions.errorHandler(e);
    }
    return null;
  }
}
