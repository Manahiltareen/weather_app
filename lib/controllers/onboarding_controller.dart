

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
var page = 0.0.obs; // Observable for current page
final pageController = PageController(); // PageController for PageView

void setPage(int index) {
page.value = index.toDouble();
}

@override
void onClose() {
pageController.dispose(); // Dispose PageController to prevent memory leaks
super.onClose();
}
}
