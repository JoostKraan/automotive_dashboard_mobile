import 'package:automotive_dashboard_mobile/pages/map.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class ActionButtonRowWidget extends StatefulWidget {
  const ActionButtonRowWidget({super.key, required this.controller});
  final Flutter3DController controller;

  @override
  State<ActionButtonRowWidget> createState() => _ActionButtonRowWidgetState();
}

class _ActionButtonRowWidgetState extends State<ActionButtonRowWidget> {
  bool tirePressureActive = false;

  void _showTirePressure() {
    widget.controller.setCameraOrbit(180.0, 0, 0);
    Future.delayed(const Duration(milliseconds: 100), () {
      widget.controller.setCameraTarget(0, 2.8, -1.2);
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      toggleTirePressureVisibility(true);
    });
  }

  void _setIsometricView() {
    widget.controller.setCameraOrbit(30, 70, 10);
    widget.controller.setCameraTarget(0.8, 1, 2);
    toggleTirePressureVisibility(false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              Container(
                width: 380,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFF222222),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color.fromARGB(255, 20, 20, 20),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 15),
                    Icon(Icons.lock_open_outlined, color: Color(0xFF8A8A89)),
                    SizedBox(width: 15),
                    Text('Unlock'),
                    Spacer(),
                    Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarMap()),
            );
          },
          child: Container(
            width: 380,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 20, 20, 20),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 15),
                Icon(Icons.location_on, color: Color(0xFF8A8A89)),
                SizedBox(width: 15),
                Text('Location'),
                Spacer(),
                Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 380,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF222222),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color.fromARGB(255, 20, 20, 20),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 15),
              Icon(Icons.build, color: Color(0xFF8A8A89)),
              SizedBox(width: 15),
              Text('Maintenance History'),
              Spacer(),
              Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
              SizedBox(width: 15),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            setState(() {
              tirePressureActive = !tirePressureActive;
              if (tirePressureActive) {
                _showTirePressure();
              } else {
                _setIsometricView();
              }
            });
          },
          child: Container(
            width: 380,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF222222),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 20, 20, 20),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 15),
                Icon(Icons.tire_repair, color: Color(0xFF8A8A89)),
                SizedBox(width: 15),
                Text('Tire Pressure'),
                Spacer(),
                Icon(Icons.chevron_right, color: Color(0xFF8A8A89)),
                SizedBox(width: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
