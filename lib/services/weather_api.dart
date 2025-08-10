import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/waether_data.dart';
import '../models/weather_model.dart';

class WeatherApi {
  // Replace with your real API key
  static const String _apiKey = '13cfc1ac72fd8cd73d9f01971aec3bb3';
  static const String _base = 'https://api.openweathermap.org/data/2.5/forecast';

  // Fetch 5-day forecast (3h interval)
  static Future<List<WeatherModel>> fetchForecast(String city) async {
    final uri = Uri.parse(
      '$_base?q=${city.trim()},PK&appid=$_apiKey&units=metric', // units=metric for °C
    );

    final res = await http.get(uri).timeout(const Duration(seconds: 15));

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch weather: ${res.statusCode} ${res.reasonPhrase}');
    }

    final Map<String, dynamic> data = jsonDecode(res.body);

    if (data['cod'] != '200' && data['cod'] != 200) {
      throw Exception(data['message'] ?? 'API error');
    }

    final List items = data['list'];
    return items
        .map((e) => WeatherModel.fromListItem(e))
        .toList()
        .cast<WeatherModel>();
  }
  static Future<WeatherData> fetchCurrentWeather(String city) async {
    final uri = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=${city.trim()},PK&appid=$_apiKey&units=metric',
    );

    final res = await http.get(uri).timeout(const Duration(seconds: 15));

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch weather: ${res.statusCode} ${res.reasonPhrase}');
    }

    final Map<String, dynamic> data = jsonDecode(res.body);

    if (data['cod'] != 200) {
      throw Exception(data['message'] ?? 'API error');
    }

    return WeatherData.fromJson(data);
  }

}
