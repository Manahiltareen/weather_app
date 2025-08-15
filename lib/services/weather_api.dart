
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/waether_data.dart';
import '../models/weather_model.dart';

class WeatherApi {
  static const String _apiKey = '13cfc1ac72fd8cd73d9f01971aec3bb3';
  static const String _baseForecast = 'https://api.openweathermap.org/data/2.5/forecast';
  static const String _baseCurrent = 'https://api.openweathermap.org/data/2.5/weather';


  static Future<List<WeatherModel>> fetchForecast(String city) async {
    final uri = Uri.parse('$_baseForecast?q=${city.trim()},PK&appid=$_apiKey&units=metric');

    final res = await http.get(uri).timeout(const Duration(seconds: 15));

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch forecast: ${res.statusCode} ${res.reasonPhrase}');
    }

    final Map<String, dynamic> data = jsonDecode(res.body);

    if (data['cod'] != '200' && data['cod'] != 200) {
      throw Exception(data['message'] ?? 'API error while fetching forecast');
    }

    final List items = data['list'] ?? [];
    return items.map((e) => WeatherModel.fromListItem(e)).toList().cast<WeatherModel>();
  }


  static Future<WeatherData> fetchCurrentWeather(String city) async {
    final uri = Uri.parse('$_baseCurrent?q=${city.trim()},PK&appid=$_apiKey&units=metric');

    final res = await http.get(uri).timeout(const Duration(seconds: 15));

    if (res.statusCode != 200) {
      throw Exception('Failed to fetch current weather: ${res.statusCode} ${res.reasonPhrase}');
    }

    final Map<String, dynamic> data = jsonDecode(res.body);

    if (data['cod'] != 200 && data['cod'] != '200') {
      throw Exception(data['message'] ?? 'API error while fetching current weather');
    }

    return WeatherData.fromJson(data);
  }
}
