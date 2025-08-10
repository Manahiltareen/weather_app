import 'package:get/get.dart';
import 'dart:async';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(milliseconds: 1500), () {
      Get.offAllNamed(Routes.ONBOARDING);
    });
  }
}
