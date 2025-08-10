import 'package:get/get.dart';
import 'package:weather_app/views/auth/onboarding_view.dart';
import 'package:weather_app/views/auth/splash_view.dart';
import 'package:weather_app/views/home/weather_view.dart';


part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.ONBOARDING, page: () => const OnboardingView()),
  ];
}
