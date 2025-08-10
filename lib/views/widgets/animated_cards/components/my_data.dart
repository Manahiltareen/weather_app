// import 'package:flutter/material.dart';
//
// // Sealed class to handle different background types
// sealed class BackgroundStyle {
//   const BackgroundStyle();
// }
//
// // Solid color background
// class SolidColorBackground extends BackgroundStyle {
//   final Color color;
//
//   const SolidColorBackground(this.color);
// }
//
// // Gradient background
// class GradientBackground extends BackgroundStyle {
//   final List<Color> colors;
//   final Gradient gradient;
//
//   GradientBackground({required this.colors, Gradient? gradient})
//     : gradient =
//           gradient ??
//           LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: colors,
//           );
// }
//
// class DummyData {
//   String platformName;
//   String userName;
//   String logo;
//   BackgroundStyle bgColor;
//   Map<String, dynamic> data;
//   String bio;
//   String linkText;
//
//   DummyData({
//     required this.platformName,
//     required this.userName,
//     required this.logo,
//     required this.bgColor,
//     required this.data,
//     required this.bio,
//     required this.linkText,
//   });
// }
//
// class DemoData {
//   final List<DummyData> _dummyData = [
//     DummyData(
//       platformName: 'LinkedIn',
//       userName: 'Imran Farooq',
//       logo: 'images/linkedin.png',
//       bgColor: SolidColorBackground(Color(0xFF0A66C2)),
//       data: {"Followers": "1050", "Connections": "500+", "Posts": "16"},
//       bio: 'Passionate Flutter Developer 🚀 | Transforming ideas into mobile apps 📱 | Always learning & evolving | Let’s connect and build something amazing!',
//       linkText: 'Connect on LinkedIn'
//     ),
//     DummyData(
//       platformName: 'Github',
//       userName: 'Mani821',
//       logo: 'images/github.png',
//       bgColor: SolidColorBackground(Color(0xFF24292F)),
//       data: {"Languages": "Dart/React", "Repos": "60+", "Packages": "1"},
//       bio: "Open-source enthusiast 👨‍💻 | Flutter & React Dev | 60+ repos & counting 🚀 | Building, breaking, and fixing code daily! 🔥",
//         linkText: 'Follow on Github'
//     ),
//     DummyData(
//       platformName: 'Instagram',
//       userName: 'luvemani',
//       logo: 'images/insta.png',
//       bgColor: GradientBackground(
//         colors: [Color(0xFF833AB4), Color(0xFFFD1D1D), Color(0xFFFCAF45)],
//       ),
//       data: {"Followers": "540", "Posts": "1", "Following": "47"},
//       bio: "📱 Code by day, content by night | Love tech, travel & creativity | Sharing snippets of life & dev adventures 🚀",
//         linkText: 'Follow on Instagram'
//
//     ),
//     DummyData(
//       platformName: 'X',
//       userName: 'luvemani',
//       logo: 'images/x.png',
//       bgColor: SolidColorBackground(Color(0xFF000000)),
//      data: {"Followers": "540", "Posts": "1", "Following": "47"},
//       bio: "Flutter & React Dev 🚀 | Open Source Contributor | Learning & sharing tech insights | Follow for dev tips & project updates!",
//       linkText: 'Follow on X'
//
//     ),
//   ];
//
//   get dummyData => _dummyData;
//
//   getBoardingPass(int index) {
//     return _dummyData.elementAt(index);
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/waether_data.dart'; // Assuming this is the path to your WeatherData model

// Background styles
sealed class BackgroundStyle {
  const BackgroundStyle();
}

class SolidColorBackground extends BackgroundStyle {
  final Color color;
  const SolidColorBackground(this.color);
}

class GradientBackground extends BackgroundStyle {
  final List<Color> colors;
  final Gradient gradient;

  GradientBackground({required this.colors, Gradient? gradient})
      : gradient = gradient ??
      LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: colors,
      );
}

// Single DummyData class for both social & weather
class DummyData {
  final String platformName; // or cityName for weather
  final String userName; // or empty or some placeholder for weather
  final String logo; // image path or icon path
  final BackgroundStyle bgColor;
  final Map<String, dynamic> data; // can hold followers or temp etc
  final String bio; // description or bio
  final String linkText;
  final IconData? weatherIcon;
  final String? weatherMain;
  final String? dateTime;

  DummyData({
    required this.platformName,
    required this.userName,
    required this.logo,
    required this.bgColor,
    required this.data,
    required this.bio,
    required this.linkText,
    this.weatherIcon,
    this.weatherMain,
    this.dateTime,
  });
}

class DemoData {
  final List<DummyData> _dummyData = [];

  // Method to create DummyData from WeatherData
  DummyData _createDummyDataFromWeather(WeatherData weather, bool isDarkMode) {
    IconData? weatherIcon;
    BackgroundStyle bgColor;
    String bio;

    switch (weather.main.toLowerCase()) {
      case 'clouds':
        weatherIcon = Icons.cloud;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.grey[800]!)
            : GradientBackground(colors: [Colors.grey[400]!, Colors.grey[600]!]);
        bio = 'Overcast skies with ${weather.main.toLowerCase()} in ${weather.cityName}.';
        break;
      case 'rain':
        weatherIcon = Icons.water_drop;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.blueGrey[800]!)
            : GradientBackground(colors: [Colors.blue[400]!, Colors.blue[700]!]);
        bio = 'Expect ${weather.main.toLowerCase()} showers in ${weather.cityName}.';
        break;
      case 'clear':
        weatherIcon = Icons.wb_sunny;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.yellow[900]!)
            : GradientBackground(colors: [Colors.yellow[400]!, Colors.orange[600]!]);
        bio = 'Bright and ${weather.main.toLowerCase()} skies in ${weather.cityName}.';
        break;
      default:
        weatherIcon = Icons.wb_cloudy; // Replaced Icons.weather_mixed
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.grey[800]!)
            : SolidColorBackground(Colors.grey[300]!);
        bio = 'Weather in ${weather.cityName}: ${weather.main}.';
    }

    return DummyData(
      platformName: weather.cityName,
      userName: weather.main,
      logo: weatherIcon.toString(), // Store icon name as string (e.g., "Icons.wb_sunny")
      bgColor: bgColor,
      data: {
        "Temp": "${weather.temp.toStringAsFixed(1)}°C",
        "Humidity": "${weather.humidity}%",
        "Wind": "${weather.wind} m/s",
        "Pressure": "${weather.pressure} hPa",
      },
      bio: bio,
      linkText: 'More details',
      weatherIcon: weatherIcon,
      weatherMain: weather.main,
      dateTime: DateFormat('MMM d, yyyy • h:mm a').format(weather.dateTime),
    );
  }

  // Constructor to initialize with WeatherData list
  DemoData(List<WeatherData> weatherDataList, bool isDarkMode) {
    _dummyData.addAll(
      weatherDataList.map((weather) => _createDummyDataFromWeather(weather, isDarkMode)).toList(),
    );
  }

  get dummyData => _dummyData;

  getBoardingPass(int index) {
    return _dummyData.elementAt(index);
  }
}