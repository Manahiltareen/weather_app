import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const ForecastCard({super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time),
            const SizedBox(height: 8),
            Icon(icon),
            const SizedBox(height: 8),
            Text(temp, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
