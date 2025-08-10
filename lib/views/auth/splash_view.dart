import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/splash_controller.dart';

import '../../theme/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [AppColors.primary, AppColors.gradientSunnyEnd]),
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.cloud, size: 84, color: Colors.white),
            const SizedBox(height: 16),
            Text('Pakistan Weather App', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))
          ]),
        ),
      ),
    );
  }
}
