
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:weather_app/controllers/theme_controller.dart';
import 'package:weather_app/views/main_nav.dart';
import 'package:weather_app/theme/app_colors.dart';
import '../widgets/animated_cards/components/card.dart';
import '../widgets/animated_cards/components/my_data.dart';

class AllCitiesView extends StatefulWidget {
  const AllCitiesView({super.key});

  @override
  State<AllCitiesView> createState() => _AllCitiesViewState();
}

class _AllCitiesViewState extends State<AllCitiesView> {
  late final List<DummyData> _demoCards;
  final Color _backgroundColor = Color(0xFFf0f0f0);
  final ScrollController _scrollController = ScrollController();
  final List<int> _openCards = [];

  @override
  void initState() {
    super.initState();
    final ctrl = Get.find<WeatherController>();
    final themeCtrl = Get.put(ThemeController());
    _demoCards = DemoData(ctrl.cityWeathers.toList(), themeCtrl.isDarkMode.value).dummyData;

  }

  @override
  Widget build(BuildContext context) {
    final themeCtrl = Get.find<ThemeController>();
    final isDarkMode = themeCtrl.isDarkMode.value;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.darkBg : _backgroundColor,
      appBar: _buildAppBar(isDarkMode),
      body: Obx(() {
        final ctrl = Get.find<WeatherController>();
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

        // Update _demoCards when cityWeathers changes
        _demoCards.clear();
        _demoCards.addAll(DemoData(ctrl.cityWeathers, isDarkMode).dummyData);

        return Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemCount: _demoCards.length,
                itemBuilder: (context, index) {
                  return MyCard(
                    dummyData: _demoCards.elementAt(index),
                    // isOpen: _openCards.contains(index),
                    onClick: () => _handleClickedCard(index),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  bool _handleClickedCard(int clickedTicket) {
    setState(() {
      if (_openCards.contains(clickedTicket)) {
        _openCards.remove(clickedTicket);
      } else {
        _openCards.add(clickedTicket);
      }

      double openTicketsOffset =
          MyCard.nominalOpenHeight * _getOpenCardsBefore(clickedTicket);
      double closedTicketsOffset =
          MyCard.nominalClosedHeight * (clickedTicket - _getOpenCardsBefore(clickedTicket));

      double offset =
          openTicketsOffset + closedTicketsOffset - (MyCard.nominalClosedHeight * 0.5);
      _scrollController.animateTo(
        max(0, offset),
        duration: Duration(seconds: 1),
        curve: Interval(0.25, 1, curve: Curves.easeOutQuad),
      );
    });

    // Navigate to MainNav when card is closed
    if (!_openCards.contains(clickedTicket)) {
      final ctrl = Get.find<WeatherController>();
      ctrl.fetch(_demoCards[clickedTicket].platformName);
      Get.to(() => const MainNav());
    }
    return true;
  }

  int _getOpenCardsBefore(int ticketIndex) {
    return _openCards.where((int index) => index < ticketIndex).length;
  }

  PreferredSizeWidget _buildAppBar(bool isDarkMode) {
    Color appBarIconsColor = isDarkMode ? Colors.white : Color(0xFF212121);
    return AppBar(
      backgroundColor: isDarkMode ? AppColors.darkBg : _backgroundColor,
      elevation: 0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Weather Dashboard'.toUpperCase(),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 15,
            letterSpacing: 0.5,
            color: appBarIconsColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}