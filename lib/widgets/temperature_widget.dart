import 'package:flutter/material.dart';

class TemperatureWidget extends StatelessWidget {
  final double interiorTemp;
  final double exteriorTemp;
  final double size;

  const TemperatureWidget({
    super.key,
    this.interiorTemp = 21.0,
    this.exteriorTemp = -30.0,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(255, 20, 20, 20),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Interior
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car,
                    color: const Color(0xFF60A5FA),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'IN',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${interiorTemp.toStringAsFixed(0)}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),

          Container(height: 1, color: const Color(0xFF334155)),

          Column(
            children: [
              Text(
                '${exteriorTemp.toStringAsFixed(0)}°',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: const Color(0xFFFB923C),
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'OUT',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
