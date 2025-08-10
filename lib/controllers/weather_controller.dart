import 'package:get/get.dart';
import 'package:weather_app/models/waether_data.dart';
import 'package:weather_app/models/weather_model.dart';
// Current weather ka model
import 'package:weather_app/services/weather_api.dart';

class WeatherController extends GetxController {
  final city = 'Karachi'.obs;
  final isLoading = false.obs;
  final error = ''.obs;

  // 5-day forecast list
  final forecasts = <WeatherModel>[].obs;

  // Current weather data for multiple cities
  final cityWeathers = <WeatherData>[].obs;

  // Pakistan cities list
  final List<String> pakCities = [
    'Karachi',
    'Lahore',
    'Islamabad',
    'Peshawar',
    'Quetta',
    'Multan',
    'Faisalabad',
    'Hyderabad',
    'Sialkot',
    'Gujranwala'
  ];

  @override
  void onInit() {
    super.onInit();
    fetch(city.value); // Load home screen default city forecast
  }

  // Fetch forecast for selected city
  Future<void> fetch(String newCity) async {
    try {
      error.value = '';
      isLoading.value = true;
      city.value = newCity;
      final data = await WeatherApi.fetchForecast(newCity);
      forecasts.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch current weather for all cities
  Future<void> fetchAllCities() async {
    isLoading.value = true;
    error.value = "";
    try {
      cityWeathers.clear();
      for (var c in pakCities) {
        final data = await WeatherApi.fetchCurrentWeather(c);
        cityWeathers.add(data);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
