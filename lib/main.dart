import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/routes/app_pages.dart';
import 'package:weather_app/theme/dark_theme.dart';
import 'package:weather_app/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pakistan Weather App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
      builder: (context, child) {
        // global text theme using google fonts
        return MediaQuery(
          data: MediaQuery.of(context),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
