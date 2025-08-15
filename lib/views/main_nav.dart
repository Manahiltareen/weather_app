
import 'package:flutter/material.dart';
import 'package:weather_app/theme/app_colors.dart';
import 'package:weather_app/views/home/weather_view.dart';
import 'package:weather_app/views/home/all_cities_view.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});

  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 0;

  final _screens = [
    const WeatherView(),
    const AllCitiesView(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.gradientCloudyEnd,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: isDark ? const Color(0xFF2C2C34) : Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: isDark ? Colors.white70 : Colors.grey,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city, size: 30),
            label: 'Cities',
          ),
        ],
      ),
    );
  }
}
