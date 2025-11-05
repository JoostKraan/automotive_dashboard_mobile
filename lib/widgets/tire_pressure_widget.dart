import 'package:flutter/material.dart';
import 'package:automotive_dashboard_mobile/widgets/tire_pressure_component_widget.dart';

// Global ValueNotifier to control visibility
final ValueNotifier<bool> tirePressureVisible = ValueNotifier(false);

class TirePressureWidget extends StatelessWidget {
  const TirePressureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: tirePressureVisible,
      builder: (context, isVisible, child) {
        return Stack(
          children: [
            _AnimatedTirePressureComponent(
              isVisible: isVisible,
              top: 45,
              left: 40,
            ),
            _AnimatedTirePressureComponent(
              isVisible: isVisible,
              bottom: 45,
              left: 40,
            ),
            _AnimatedTirePressureComponent(
              isVisible: isVisible,
              top: 45,
              right: 40,
            ),
            _AnimatedTirePressureComponent(
              isVisible: isVisible,
              bottom: 45,
              right: 40,
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedTirePressureComponent extends StatelessWidget {
  final bool isVisible;
  final double? top, bottom, left, right;

  const _AnimatedTirePressureComponent({
    required this.isVisible,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.8, end: isVisible ? 1.0 : 0.8),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        builder: (context, scale, child) {
          return AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Transform.scale(scale: scale, child: child),
          );
        },
        child: const TirePressureComponentWidget(),
      ),
    );
  }
}

void toggleTirePressureVisibility(bool isVisible) {
  tirePressureVisible.value = isVisible;
}
