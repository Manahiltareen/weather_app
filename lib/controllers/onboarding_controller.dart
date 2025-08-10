import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final page = 0.obs;
  void setPage(int i) => page.value = i;
}
