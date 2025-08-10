import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/onboarding_controller.dart';
import 'package:weather_app/routes/app_routes.dart';

import '../../routes/app_pages.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(OnboardingController());
    final pages = [
      _page(context, 'Welcome', 'Pakistan weather at your fingertips'),
      _page(context, 'City Selector', 'Choose any Pakistani city quickly'),
      _page(context, 'Beautiful UI', 'Clean, responsive and theming ready'),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: ctrl.setPage,
                itemCount: pages.length,
                itemBuilder: (c, i) => pages[i],
              ),
            ),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(pages.length, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.all(4),
                width: ctrl.page.value == i ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: ctrl.page.value == i ? Theme.of(context).primaryColor : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
              )),
            )),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child:ElevatedButton(
                onPressed: () {
                  // yahan SharedPreferences me save karo ke user ne onboarding dekh li
                  Get.offAllNamed(AppRoutes.navbar);
                },
                child: Text("Get Started"),
              )

            ),
          ],
        ),
      ),
    );
  }

  Widget _page(BuildContext c, String t, String s) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.cloud_circle, size: 120, color: Theme.of(c).primaryColor),
        const SizedBox(height: 28),
        Text(t, style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(s, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
      ]),
    );
  }
}
