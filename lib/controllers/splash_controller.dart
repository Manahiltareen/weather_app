// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weather_app/routes/app_routes.dart';
// import 'package:flutter/foundation.dart'; // For debugPrint
//
// class SplashController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();
//     _navigateAfterDelay();
//   }
//
//   Future<void> _navigateAfterDelay() async {
//     try {
//       await Future.delayed(const Duration(seconds: 2)); // 2-second delay
//       final prefs = await SharedPreferences.getInstance();
//       final hasSeenOnboarding = prefs.getBool('onboarding_seen') ?? false;
//       debugPrint('Onboarding seen: $hasSeenOnboarding');
//       if (hasSeenOnboarding) {
//         debugPrint('Navigating to navbar');
//         Get.offAllNamed(AppRoutes.navbar);
//       } else {
//         debugPrint('Navigating to onboarding');
//         Get.offAllNamed(AppRoutes.onboarding);
//       }
//     } catch (e) {
//       debugPrint('Navigation error: $e');
// // Fallback navigation to onboarding to avoid getting stuck
//       Get.offAllNamed(AppRoutes.onboarding);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint('SplashController: onInit called at ${DateTime.now()}');
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    try {
      debugPrint('SplashController: Waiting for 2 seconds');
      await Future.delayed(const Duration(seconds: 2)); // 2-second delay
      debugPrint('SplashController: Delay completed');
      final prefs = await SharedPreferences.getInstance();
      debugPrint('SplashController: SharedPreferences loaded');
      final hasSeenOnboarding = prefs.getBool('onboarding_seen') ?? false;
      debugPrint('SplashController: Onboarding seen: $hasSeenOnboarding');
      if (hasSeenOnboarding) {
        debugPrint('SplashController: Navigating to ${AppRoutes.navbar}');
        Get.offAllNamed(AppRoutes.navbar);
      } else {
        debugPrint('SplashController: Navigating to ${AppRoutes.onboarding}');
        Get.offAllNamed(AppRoutes.onboarding);
      }
    } catch (e, stackTrace) {
      debugPrint('SplashController: Navigation error: $e');
      debugPrint('SplashController: Stack trace: $stackTrace');
// Fallback to onboarding
      debugPrint('SplashController: Falling back to ${AppRoutes.onboarding}');
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

