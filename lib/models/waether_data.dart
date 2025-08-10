import 'package:flutter/foundation.dart';

class WeatherData {
  final String cityName;
  final double temp;
  final String main;
  final int humidity;
  final double wind;
  final int pressure;
  final DateTime dateTime; // <-- required field

  WeatherData({
    required this.cityName,
    required this.temp,
    required this.main,
    required this.humidity,
    required this.wind,
    required this.pressure,
    required this.dateTime,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    // parse UNIX timestamp (could be int or string)
    int timestamp = 0;
    try {
      final raw = json['dt'];
      if (raw is int) {
        timestamp = raw;
      } else if (raw is String) {
        timestamp = int.tryParse(raw) ?? 0;
      } else if (raw is double) {
        timestamp = raw.toInt();
      }
    } catch (_) {
      timestamp = 0;
    }

    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    return WeatherData(
      cityName: (json['name'] ?? '').toString(),
      temp: ((json['main']?['temp']) ?? 0).toDouble(),
      main: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['main'].toString()
          : '',
      humidity: (json['main']?['humidity'] ?? 0).toInt(),
      wind: ((json['wind']?['speed']) ?? 0).toDouble(),
      pressure: (json['main']?['pressure'] ?? 0).toInt(),
      dateTime: dt,
    );
  }
}
