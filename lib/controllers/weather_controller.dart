import 'package:get/get.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_api.dart';

class WeatherController extends GetxController {
  final city = 'Karachi'.obs;
  final isLoading = false.obs;
  final error = ''.obs;
  final forecasts = <WeatherModel>[].obs;

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
    fetch(city.value);
  }

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
}
