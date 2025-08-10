import 'package:flutter/material.dart';
import 'package:weather_app/theme/app_colors.dart';
import 'package:weather_app/views/home/cities.dart';
import 'package:weather_app/views/home/cities_screen.dart';
import 'package:weather_app/views/home/weather_view.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 0;

  final _screens = [
    const WeatherView(),
    const CitiesScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.gradientCloudyEnd,
      body: _screens[_currentIndex],

      // floating, rounded container bottom nav
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Color(0xFF2C2C34) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Home Icon
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 0),
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: _currentIndex == 0
                      ? Colors.orange
                      : (isDark ? Colors.white70 : Colors.grey),
                ),
              ),

              // Cities Icon
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                child: Icon(
                  Icons.location_city,
                  size: 30,
                  color: _currentIndex == 1
                      ? Colors.orange
                      : (isDark ? Colors.white70 : Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
