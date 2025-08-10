import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/theme/app_colors.dart';
import 'package:weather_app/views/widgets/additional_info_card.dart';
import 'package:weather_app/views/widgets/forecast_card.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(WeatherController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pakistan Weather App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => ctrl.fetch(ctrl.city.value),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.error.isNotEmpty) {
          return Center(child: Text(ctrl.error.value));
        }
        if (ctrl.forecasts.isEmpty) {
          return const Center(child: Text('No data'));
        }

        final current = ctrl.forecasts.first;
        // choose gradient based on weather
        final main = current.main.toLowerCase();
        List<Color> bgGradient = [AppColors.gradientSunnyStart, AppColors.gradientSunnyEnd];
        if (main.contains('cloud')) bgGradient = [AppColors.gradientCloudyStart, AppColors.gradientCloudyEnd];
        if (main.contains('rain')) bgGradient = [AppColors.gradientRainStart, AppColors.gradientRainEnd];

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: bgGradient, begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Header: Pakistan label + city selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Pakistan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      DropdownButton<String>(
                        value: ctrl.city.value,
                        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                        items: ctrl.pakCities.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) {
                          if (v != null) ctrl.fetch(v);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Temperature Card
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('${ctrl.tempInC(current.temp)} °C', style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('${toBeginningOfSentenceCase(current.main) ?? current.main}', style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 4),
                            Text('Updated: ${DateFormat.yMMMd().add_jm().format(current.dateTime)}'),
                          ]),
                          const Spacer(),
                          Icon(
                            current.main.contains('Cloud') || current.main.contains('cloud') ? Icons.cloud : Icons.wb_sunny,
                            size: 72,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Forecast horizontal
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (c, i) {
                        final item = ctrl.forecasts.length > i ? ctrl.forecasts[i] : ctrl.forecasts.last;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: ForecastCard(
                            time: DateFormat.j().format(item.dateTime),
                            icon: item.main.toLowerCase().contains('cloud') ? Icons.cloud : Icons.wb_sunny,
                            temp: '${ctrl.tempInC(item.temp)}°C',
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Additional Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdditionalInfoCard(icon: Icons.water_drop_outlined, label: 'Humidity', value: '${current.humidity}%'),
                      AdditionalInfoCard(icon: Icons.air, label: 'Wind', value: '${current.wind} m/s'),
                      AdditionalInfoCard(icon: Icons.speed, label: 'Pressure', value: '${current.pressure} hPa'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
