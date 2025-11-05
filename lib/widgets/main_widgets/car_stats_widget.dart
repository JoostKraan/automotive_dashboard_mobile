import 'package:automotive_dashboard_mobile/widgets/progession_dial_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/temperature_widget.dart';
import 'package:flutter/material.dart';

class CarStatsWidget extends StatefulWidget {
  const CarStatsWidget({super.key});

  @override
  State<CarStatsWidget> createState() => _CarStatsWidgetState();
}

class _CarStatsWidgetState extends State<CarStatsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(255, 31, 31, 31),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Fuel',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
                SizedBox(height: 8),
                FuelProgressCircle(
                  percentage: 0.34,
                  size: 100,
                  backgroundColor: const Color.fromARGB(255, 41, 41, 41),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Temperature',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                TemperatureWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
