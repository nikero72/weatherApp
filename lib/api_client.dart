import 'dart:convert';
import 'dart:io';

import 'package:location/location.dart';
import 'package:weather_app/geolocation.dart';



class ApiClient {
  final client = HttpClient();
  CurrentWeather? currentWeather;
  Forecast? forecast;

  
  Future<CurrentWeather?> getCurrentWeather() async {
    LocationData? locationData = await Geolocation().getLocation();
    String lat = locationData?.latitude.toString() ?? '55.7522';
    String lon = locationData?.longitude.toString() ?? '37.6156';
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=385bb906e33f38e8e09025c818d7ab22&units=metric&lang=ru');
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    currentWeather = CurrentWeather.fromJson(json);
    return currentWeather;
  }

  Future<Forecast?> getForecast() async {
    LocationData? locationData = await Geolocation().getLocation();
    String lat = locationData?.latitude.toString() ?? '55.7522';
    String lon = locationData?.longitude.toString() ?? '37.6156';
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=385bb906e33f38e8e09025c818d7ab22&units=metric&cnt=8&lang=ru');
    final request = await client.getUrl(url);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    forecast = Forecast.fromJson(json);
    return forecast;
  }
  
}

class CurrentWeather {
  String main;
  String description;
  double mainTemp;
  double feelsLike;
  int pressure;
  int humidity;
  double windSpeed;
  int windDeg;
  String city;

  CurrentWeather({
    required this.main,
    required this.description,
    required this.mainTemp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.city
  });

  factory CurrentWeather.fromJson(dynamic json) {
    return CurrentWeather(
        main: (json['weather'] as List<dynamic>)
            .map((dynamic e) => JsonWeather.fromJson(e as Map<String, dynamic>))
            .toList().elementAt(0).main,
        description: (json['weather'] as List<dynamic>)
            .map((dynamic e) => JsonWeather.fromJson(e as Map<String, dynamic>))
            .toList().elementAt(0).description,
        mainTemp: JsonMain.fromJson(json['main'] as Map<String, dynamic>).maintemp,
        feelsLike: JsonMain.fromJson(json['main'] as Map<String, dynamic>).feelslike,
        pressure: JsonMain.fromJson(json['main'] as Map<String, dynamic>).pressure,
        humidity: JsonMain.fromJson(json['main'] as Map<String, dynamic>).humidity,
        windSpeed: JsonWind.fromJson(json['wind'] as Map<String, dynamic>).windspeed,
        windDeg: JsonWind.fromJson(json['wind'] as Map<String, dynamic>).winddeg,
        city: json['name'] as String
    );
  }
}

class JsonWeather {
  final String main;
  final String description;

  JsonWeather({
    required this.main,
    required this.description,
  });

  factory JsonWeather.fromJson(dynamic json) {
    return JsonWeather(
        main: json['main'] as String,
        description: json['description'] as String
    );
  }
}

class JsonMain {
  final double maintemp;
  final double feelslike;
  final int pressure;
  final int humidity;

  JsonMain({
    required this.maintemp,
    required this.feelslike,
    required this.pressure,
    required this.humidity,
  });

  factory JsonMain.fromJson(dynamic json) {
    return JsonMain(
      maintemp: (json['temp']).toDouble(),
      feelslike: (json['feels_like']).toDouble(),
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int
    );
  }
}

class JsonWind {
  final double windspeed;
  final int winddeg;

  JsonWind({
    required this.windspeed,
    required this.winddeg,
  });

  factory JsonWind.fromJson(dynamic json) {
    return JsonWind(
        windspeed: (json['speed']).toDouble(),
        winddeg: json['deg'] as int,
    );
  }
}

class Forecast {
  final List<double> mainTemp;
  final List<String> weatherMain;
  final List<String> time;

  Forecast({
    required this.mainTemp,
    required this.weatherMain,
    required this.time
  });


  factory Forecast.fromJson(dynamic json) {
    return Forecast(
        mainTemp:
        (json['list'] as List<dynamic>)
            .map((dynamic e) => (JsonForecastMain.fromJson(e as Map<String, dynamic>)).mainTemp).toList(),
        weatherMain:
        (json['list'] as List<dynamic>)
            .map((dynamic e) => (JsonForecastWeather.fromJson(e as Map<String, dynamic>)).weatherMain).toList(),
        time:
        (json['list'] as List<dynamic>)
            .map((dynamic e) => (JsonForecastTime.fromJson(e as Map<String, dynamic>)).time).toList()
    );
  }
}

class JsonForecastMain {
  final double mainTemp;

  JsonForecastMain({
    required this.mainTemp
  });

  factory JsonForecastMain.fromJson(dynamic json) {
    return JsonForecastMain(
        mainTemp: (json['main'] as Map<String, dynamic>)['temp'] as double
    );
  }
}

class JsonForecastWeather {
  final String weatherMain;

  JsonForecastWeather({
    required this.weatherMain
  });

  factory JsonForecastWeather.fromJson(dynamic json) {
    return JsonForecastWeather(
        weatherMain: ((json['weather'] as List<dynamic>).elementAt(0) as Map<String, dynamic>)['main'] as String
    );
  }
}

class JsonForecastTime {
  final String time;

  JsonForecastTime({
    required this.time
  });

  factory JsonForecastTime.fromJson(dynamic json) {
    return JsonForecastTime(
        time: (json['dt_txt'] as String).substring(11, 16)
    );
  }
}