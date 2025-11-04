import 'dart:math';
import 'package:flutter/material.dart';

class FuelProgressCircle extends StatelessWidget {
  final double percentage; // 0.0 to 1.0
  final double size;
  final Color backgroundColor;
  final Color progressColor;

  const FuelProgressCircle({
    Key? key,
    required this.percentage,
    this.size = 120,
    this.backgroundColor = const Color(0xFF1E293B),
    this.progressColor = const Color(0xFF13FF86),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: FuelProgressPainter(
        percentage: percentage,
        backgroundColor: backgroundColor,
        progressColor: progressColor,
      ),
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(percentage * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4),
              Icon(Icons.local_gas_station, color: Color(0xFF8A8A89)),
            ],
          ),
        ),
      ),
    );
  }
}

class FuelProgressPainter extends CustomPainter {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;

  FuelProgressPainter({
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 12.0;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * pi * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(FuelProgressPainter oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}
