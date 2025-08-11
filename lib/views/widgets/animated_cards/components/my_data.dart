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


class DummyData {
  final String platformName; // or cityName
  final String userName; // or weather main
  final String logo;
  final BackgroundStyle bgColor;
  final Map<String, dynamic> data;
  final String bio;
  final String linkText;
  final IconData? weatherIcon;
  final Color? iconColor;       // <-- Add this
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
    this.iconColor,          // <-- Add this
    this.weatherMain,
    this.dateTime,
  });
}

class DemoData {
  final List<DummyData> _dummyData = [];

  DemoData(List<WeatherData> weatherDataList, bool isDarkMode) {
    _dummyData.addAll(
      weatherDataList.map((weather) => _createDummyDataFromWeather(weather, isDarkMode)).toList(),
    );
  }

  List<DummyData> get dummyData => _dummyData;

  DummyData _createDummyDataFromWeather(WeatherData weather, bool isDarkMode) {
    IconData weatherIcon;
    Color iconColor;
    BackgroundStyle bgColor;
    String bio;

    switch (weather.main.toLowerCase()) {
      case 'clouds':
        weatherIcon = Icons.cloud;
        iconColor = isDarkMode ? Colors.grey[300]! : Colors.blueGrey[700]!;
        bgColor = isDarkMode
            ? SolidColorBackground(Color(0xFF2C3E50)) // dark blue-grey
            : GradientBackground(colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)]); // soft blue gradient
        bio = 'Overcast skies with clouds in ${weather.cityName}.';
        break;

      case 'rain':
        weatherIcon = Icons.water_drop;
        iconColor = isDarkMode ? Colors.lightBlue[300]! : Colors.blue[800]!;
        bgColor = isDarkMode
            ? SolidColorBackground(Color(0xFF34495E)) // dark slate blue
            : GradientBackground(colors: [Color(0xFF667eea), Color(0xFF764ba2)]); // purple-blue gradient
        bio = 'Expect rain showers in ${weather.cityName}.';
        break;

      case 'clear':
        weatherIcon = Icons.wb_sunny;
        iconColor = isDarkMode ? Colors.amber[300]! : Colors.orange[600]!;
        bgColor = isDarkMode
            ? SolidColorBackground(Color(0xFFF39C12)) // dark amber
            : GradientBackground(colors: [Color(0xFFFFE259), Color(0xFFFFA751)]); // warm yellow-orange gradient
        bio = 'Bright and clear skies in ${weather.cityName}.';
        break;

      default:
        weatherIcon = Icons.wb_cloudy;
        iconColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
        bgColor = isDarkMode
            ? SolidColorBackground(Color(0xFF34495E))
            : SolidColorBackground(Color(0xFFBDC3C7));
        bio = 'Weather in ${weather.cityName}: ${weather.main}.';
    }

    return DummyData(
      platformName: weather.cityName,
      userName: weather.main,
      logo: weatherIcon.toString(),
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
      iconColor: iconColor,
      weatherMain: weather.main,
      dateTime: DateFormat('MMM d, yyyy • h:mm a').format(weather.dateTime),
    );
  }

  DummyData getBoardingPass(int index) {
    return _dummyData.elementAt(index);
  }
}
