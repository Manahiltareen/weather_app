import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controllers/theme_controller.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/models/waether_data.dart';
import 'package:weather_app/views/main_nav.dart';
import 'package:weather_app/theme/app_colors.dart';

// Sealed class to handle different background types
sealed class BackgroundStyle {
  const BackgroundStyle();
}

// Solid color background
class SolidColorBackground extends BackgroundStyle {
  final Color color;
  const SolidColorBackground(this.color);
}

// Gradient background
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

// Weather card data adapted from DummyData
class WeatherCardData {
  final String cityName;
  final String weatherMain;
  final IconData weatherIcon;
  final BackgroundStyle bgColor;
  final Map<String, dynamic> data;
  final String description;
  final String dateTime;

  WeatherCardData({
    required this.cityName,
    required this.weatherMain,
    required this.weatherIcon,
    required this.bgColor,
    required this.data,
    required this.description,
    required this.dateTime,
  });

  factory WeatherCardData.fromWeatherData(WeatherData weather, bool isDarkMode) {
    IconData icon;
    BackgroundStyle bgColor;

    switch (weather.main.toLowerCase()) {
      case 'clouds':
        icon = Icons.cloud;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.grey[800]!)
            : GradientBackground(colors: [Colors.grey[400]!, Colors.grey[600]!]);
        break;
      case 'rain':
        icon = Icons.water_drop;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.blueGrey[800]!)
            : GradientBackground(colors: [Colors.blue[400]!, Colors.blue[700]!]);
        break;
      case 'clear':
        icon = Icons.wb_sunny;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.yellow[900]!)
            : GradientBackground(colors: [Colors.yellow[400]!, Colors.orange[600]!]);
        break;
      default:
        icon = Icons.wb_cloudy;
        bgColor = isDarkMode
            ? SolidColorBackground(Colors.grey[800]!)
            : SolidColorBackground(Colors.grey[300]!);
    }

    return WeatherCardData(
      cityName: weather.cityName,
      weatherMain: weather.main,
      weatherIcon: icon,
      bgColor: bgColor,
      data: {
        "Temp": "${weather.temp.toStringAsFixed(1)}°C",
        "Humidity": "${weather.humidity}%",
        "Wind": "${weather.wind} m/s",
        "Pressure": "${weather.pressure} hPa",
      },
      description: "Weather in ${weather.cityName}: ${weather.main}",
      dateTime: DateFormat('MMM d, yyyy • h:mm a').format(weather.dateTime),
    );
  }
}

// Modified CardSummary for weather data
class WeatherCardSummary extends StatelessWidget {
  final WeatherCardData weather;
  final bool isDarkMode;

  const WeatherCardSummary({
    super.key,
    required this.weather,
    required this.isDarkMode,
  });

  Color _getBackgroundColor(BackgroundStyle background) {
    if (background is SolidColorBackground) {
      return background.color;
    }
    if (background is GradientBackground) {
      return background.colors.first;
    }
    return Colors.black;
  }

  Color get mainTextColor => isDarkMode ? Colors.white : Colors.black87;

  Color get secondaryTextColor => isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;

  Color get separatorColor => isDarkMode ? Colors.grey[300]! : AppColors.primary;

  TextStyle get bodyTextStyle => GoogleFonts.poppins(
    color: mainTextColor,
    fontSize: 13,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildHeader(),
            _buildSeparationLine(),
            _buildWeatherHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _buildWeatherIcon(),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: _buildSmallIcon(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${weather.data['Temp']}",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: mainTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildBottomIcon(),
          ],
        ),
      ),
    );
  }

  _getBackgroundDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: weather.bgColor is SolidColorBackground
          ? (weather.bgColor as SolidColorBackground).color
          : null,
      gradient: weather.bgColor is GradientBackground
          ? (weather.bgColor as GradientBackground).gradient
          : null,
    );
  }

  _buildHeader() {
    return Text(
      weather.cityName.toUpperCase(),
      style: GoogleFonts.poppins(
        color: isDarkMode ? separatorColor : _getBackgroundColor(weather.bgColor),
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildSeparationLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: separatorColor,
    );
  }

  Widget _buildWeatherHeader() {
    var headerStyle = GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: isDarkMode ? separatorColor : AppColors.primary,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(weather.weatherMain.toUpperCase(), style: headerStyle),
        Text(weather.dateTime, style: headerStyle),
      ],
    );
  }

  Widget _buildWeatherIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(
        weather.weatherIcon,
        size: 80,
        color: isDarkMode ? Colors.white : Colors.black54,
      ),
    );
  }

  Widget _buildSmallIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: 20,
          height: 58,
          child: _AnimatedSlideToRight(
            isOpen: false,
            child: Icon(
              weather.weatherIcon,
              size: 20,
              color: isDarkMode ? Colors.white : Colors.black54,
            ),
          ),
        ),
        Text(
          "Check Now",
          textAlign: TextAlign.center,
          style: bodyTextStyle,
        ),
      ],
    );
  }

  Widget _buildBottomIcon() {
    return Icon(
      Icons.keyboard_arrow_down,
      color: separatorColor,
      size: 18,
    );
  }
}

// Animated slide widget
class _AnimatedSlideToRight extends StatefulWidget {
  final Widget child;
  final bool isOpen;

  const _AnimatedSlideToRight({required this.child, required this.isOpen});

  @override
  _AnimatedSlideToRightState createState() => _AnimatedSlideToRightState();
}

class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 1700),
  );

  @override
  Widget build(BuildContext context) {
    if (widget.isOpen) controller.forward(from: 0);
    return SlideTransition(
      position: Tween(
        begin: Offset(-2, 0),
        end: Offset(1, 0),
      ).animate(CurvedAnimation(curve: Curves.easeOutQuad, parent: controller)),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

// Modified CardDetails for weather data
class WeatherCardDetails extends StatelessWidget {
  final WeatherCardData weather;

  WeatherCardDetails(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final titleTextStyle = GoogleFonts.poppins(
      fontSize: 11,
      height: 1,
      letterSpacing: 0.2,
      fontWeight: FontWeight.w600,
      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
    );
    final contentTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      height: 1.8,
      letterSpacing: 0.3,
      color: isDarkMode ? Colors.white : AppColors.primary,
    );

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: weather.data.entries.map<Widget>((entry) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(entry.key.toUpperCase(), style: titleTextStyle),
                    Text(entry.value.toString(), style: contentTextStyle),
                  ],
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              weather.description,
              style: GoogleFonts.poppins(
                fontSize: 12,
                height: 1.8,
                letterSpacing: 0.3,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Folding card widget
class FoldingCard extends StatefulWidget {
  static const double padding = 16.0;
  final bool isOpen;
  final List<FoldEntry> entries;
  final VoidCallback? onClick;
  final Duration? duration;

  const FoldingCard({
    super.key,
    this.duration,
    required this.entries,
    this.isOpen = false,
    this.onClick,
  });

  @override
  State<FoldingCard> createState() => _FoldingCardState();
}

class _FoldingCardState extends State<FoldingCard> with SingleTickerProviderStateMixin {
  late List<FoldEntry> _entries = widget.entries;
  late AnimationController controller = AnimationController(vsync: this);
  double _ratio = 0.0;

  double get openHeight =>
      _entries.fold<double>(0.0, (val, o) => val + o.height) + FoldingCard.padding * 2;

  double get closedHeight => _entries[0].height + FoldingCard.padding * 2;

  bool get isOpen => widget.isOpen;

  @override
  void initState() {
    super.initState();
    controller.addListener(_tick);
    _updateFromWidget();
  }

  @override
  void didUpdateWidget(FoldingCard oldWidget) {
    _updateFromWidget();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(FoldingCard.padding),
      height: closedHeight + (openHeight - closedHeight) * Curves.easeOut.transform(_ratio),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: _buildEntry(0),
      ),
    );
  }

  Widget _buildEntry(int index) {
    FoldEntry entry = _entries[index];
    int count = _entries.length - 1;
    double ratio = max(0.0, min(1.0, _ratio * count + 1.0 - index * 1.0));

    Matrix4 mtx = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..setEntry(1, 2, 0.2)
      ..rotateX(pi * (ratio - 1.0));

    Widget card = SizedBox(
      height: entry.height,
      child: ratio < 0.5 ? entry.back : entry.front,
    );

    return Transform(
      alignment: Alignment.topCenter,
      transform: mtx,
      child: GestureDetector(
        onTap: widget.onClick,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: (index == count || ratio <= 0.5)
              ? card
              : Column(children: [card, _buildEntry(index + 1)]),
        ),
      ),
    );
  }

  void _updateFromWidget() {
    _entries = widget.entries;
    controller.duration =
        widget.duration ?? Duration(milliseconds: 400 * (_entries.length - 1));
    isOpen ? controller.forward() : controller.reverse();
  }

  void _tick() {
    setState(() {
      _ratio = Curves.easeInQuad.transform(controller.value);
    });
  }
}

class FoldEntry {
  final Widget? front;
  late Widget? back;
  final double height;

  FoldEntry({required this.front, required this.height, Widget? back}) {
    this.back = Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(pi),
      child: back,
    );
  }
}

// CitiesScreen using FoldingCard
class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<WeatherController>();
    final themeCtrl = Get.put(ThemeController());
    final isDarkMode = themeCtrl.isDarkMode.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Cities"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (ctrl.error.isNotEmpty) {
          return Center(
            child: Text(
              ctrl.error.value,
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.red[300] : Colors.red[600],
                fontSize: 16,
              ),
            ),
          );
        }
        if (ctrl.cityWeathers.isEmpty) {
          return Center(
            child: Text(
              "No cities data",
              style: GoogleFonts.poppins(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontSize: 16,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: ctrl.cityWeathers.length,
          itemBuilder: (context, index) {
            final weatherData = ctrl.cityWeathers[index];
            final weatherCardData = WeatherCardData.fromWeatherData(weatherData, isDarkMode);
            final RxBool isOpen = false.obs;

            return Obx(() => FoldingCard(
              isOpen: isOpen.value,
              entries: [
                FoldEntry(
                  front: WeatherCardSummary(
                    weather: weatherCardData,
                    isDarkMode: isDarkMode,
                  ),
                  back: WeatherCardDetails(weatherCardData),
                  height: 150,
                ),
                FoldEntry(
                  front: WeatherCardDetails(weatherCardData),
                  height: 150,
                ),
              ],
              onClick: () {
                isOpen.value = !isOpen.value;
                if (!isOpen.value) {
                  ctrl.fetch(weatherData.cityName);
                  Get.to(() => const MainNav());
                }
              },
            ));
          },
        );
      }),
    );
  }
}