import 'package:automotive_dashboard_mobile/widgets/main_widgets/3d_model_viewer_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_component_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class CarModelWidget extends StatefulWidget {
  const CarModelWidget({super.key});

  @override
  State<CarModelWidget> createState() => _CarModelWidgetState();
}

class _CarModelWidgetState extends State<CarModelWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 500,
      child: Stack(children: [ModelViewerWidget(), TirePressureWidget()]),
    );
  }
}
