import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class CarModelWidget extends StatefulWidget {
  const CarModelWidget({super.key});

  @override
  State<CarModelWidget> createState() => _CarModelWidgetState();
}

class _CarModelWidgetState extends State<CarModelWidget> {
  final Flutter3DController _controller = Flutter3DController();

  void _setIsometricView() {
    _controller.setCameraOrbit(30, 70, 10);
    _controller.setCameraTarget(0.8, 1, 2);
  }

  Future<void> _onModelLoaded(String src) async {
    debugPrint('✅ Model loaded: $src');
    _setIsometricView();
    final animations = await _controller.getAvailableAnimations();
    debugPrint('🎬 Available animations: $animations');
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 500,
      child: Flutter3DViewer(
        controller: _controller,
        src: 'assets/models/escortwheelturntest.glb',
        enableTouch: false,
        onLoad: _onModelLoaded,
      ),
    );
  }
}
