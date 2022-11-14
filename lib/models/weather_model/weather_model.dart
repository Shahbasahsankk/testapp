class WeatherData {
  WeatherData({
    required this.daily,
  });
  final List<Daily> daily;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        daily: List<Daily>.from(
            (json["daily"] as List).map((x) => Daily.fromJson(x))),
      );
}

class Daily {
  final Temp temp;
  final dynamic windSpeed;
  final List<WeatherElement> weatherType;
  final dynamic humidity;

  Daily({
    required this.temp,
    required this.windSpeed,
    required this.weatherType,
    required this.humidity,
  });
  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      temp: Temp.fromJson(json["temp"]),
      windSpeed: json['wind_speed'],
      weatherType: (json['weather'] as List)
          .map((e) => WeatherElement.fromJson(e))
          .toList(),
      humidity: json['humidity'],
    );
  }
}

class Temp {
  Temp({
    required this.day,
  });

  final dynamic day;

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"],
      );
}

class WeatherElement {
  WeatherElement({
    required this.description,
  });

  final String description;
  factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
        description: json["description"],
      );
}
