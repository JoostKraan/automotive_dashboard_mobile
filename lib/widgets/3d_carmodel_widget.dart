import 'package:automotive_dashboard_mobile/widgets/main_widgets/3d_model_viewer_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_component_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class CarModelWidget extends StatefulWidget {
  final Flutter3DController controller;
  const CarModelWidget({super.key, required this.controller});

  @override
  State<CarModelWidget> createState() => _CarModelWidgetState();
}

class _CarModelWidgetState extends State<CarModelWidget> {
  void _setIsometricView() {
    widget.controller.setCameraOrbit(30, 70, 10);
    widget.controller.setCameraTarget(0.8, 1, 2);
  }

  Future<void> _onModelLoaded(String src) async {
    debugPrint('✅ Model loaded: $src');
    _setIsometricView();
    final animations = await widget.controller.getAvailableAnimations();
    debugPrint('🎬 Available animations: $animations');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 500,
      child: Stack(
        children: [
          // Flutter3DViewer(
          //   controller: widget.controller,
          //   src: 'assets/models/escortwheelturntest.glb',
          //   enableTouch: false,
          //   onLoad: _onModelLoaded,
          // ),
          ModelViewerWidget(),
          //TirePressureWidget(),
        ],
      ),
    );
  }
}
