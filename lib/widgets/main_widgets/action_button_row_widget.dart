import 'package:automotive_dashboard_mobile/controllers/camera_controller.dart';
import 'package:automotive_dashboard_mobile/pages/map.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:three_js/three_js.dart' show Vector3;

class ActionButtonRowWidget extends StatefulWidget {
  const ActionButtonRowWidget({super.key});

  @override
  State<ActionButtonRowWidget> createState() => _ActionButtonRowWidgetState();
}

class _ActionButtonRowWidgetState extends State<ActionButtonRowWidget> {
  bool tirePressureActive = false;
  void _showTirePressure() {
    final cameraController = context.read<CameraController>(); //
    cameraController.camera?.position?.setValues(0, 10, -7);
    cameraController.camera?.lookAt(Vector3(0, 1, 0));

    Future.delayed(const Duration(milliseconds: 300), () {
      toggleTirePressureVisibility(true);
    });
  }

  void _setIsometricView() {
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
              color: tirePressureActive
                  ? const Color(0xFF1E88E5)
                  : const Color(0xFF222222), // Blue if active
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
