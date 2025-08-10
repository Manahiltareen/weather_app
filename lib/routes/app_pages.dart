import 'package:get/get.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/views/auth/onboarding_view.dart';
import 'package:weather_app/views/auth/splash_view.dart';
import 'package:weather_app/views/home/weather_view.dart';




// class AppPages {
//   static final pages = [
//     GetPage(name: Routes.SPLASH, page: () => const SplashView()),
//     GetPage(name: Routes.ONBOARDING, page: () => const OnboardingView()),
//   ];
// }
class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
      // binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingView(),
      // binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.weather,
      page: () => WeatherView(),
      // binding: WeatherBinding(),
    ),
  ];
}
