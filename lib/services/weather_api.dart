import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherApi {
  // Replace with your OpenWeatherMap API key
  static const String _apiKey = 'YOUR_API_KEY_HERE';
  static const String _base = 'https://api.openweathermap.org/data/2.5/forecast';

  // fetch 5-day forecast (3h interval)
  static Future<List<WeatherModel>> fetchForecast(String city) async {
    final uri = Uri.parse('$_base?q=$city,PK&appid=$_apiKey');
    final res = await http.get(uri).timeout(const Duration(seconds: 15));
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch weather: ${res.body}');
    }

    final Map<String, dynamic> data = jsonDecode(res.body);
    if (data['cod'] != '200' && data['cod'] != 200) {
      throw Exception(data['message'] ?? 'API error');
    }
    final List items = data['list'];
    return items.map((e) => WeatherModel.fromListItem(e)).toList().cast<WeatherModel>();
  }
}
