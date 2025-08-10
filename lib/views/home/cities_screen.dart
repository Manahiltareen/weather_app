import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/views/main_nav.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(WeatherController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Cities"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.error.isNotEmpty) {
          return Center(child: Text(ctrl.error.value));
        }
        if (ctrl.cityWeathers.isEmpty) {
          return const Center(child: Text("No cities data"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: ctrl.cityWeathers.length,
          itemBuilder: (context, index) {
            final cityData = ctrl.cityWeathers[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(18),
                title: Text(
                  cityData.cityName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                    "${cityData.main} • ${DateFormat.jm().format(cityData.dateTime)}",
                    style: const TextStyle(fontSize: 14),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      child: Text(
                        "${cityData.temp.toStringAsFixed(1)}°C",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Icon(
                        cityData.main.toLowerCase().contains("cloud") ? Icons.cloud : Icons.wb_sunny,
                        color: Colors.orange,
                        size: 24,
                      ),
                    ),

                ],
                ),
              ),
            );
          },
        );
      }),

    );
  }
}
