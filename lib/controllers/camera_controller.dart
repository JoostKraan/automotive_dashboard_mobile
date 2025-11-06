import 'package:flutter/material.dart';
import 'package:three_js/three_js.dart' as three;

class CameraController extends ChangeNotifier {
  three.Camera? _camera; // accept any kind of camera

  void setCamera(three.Camera camera) {
    _camera = camera;
    notifyListeners();
  }

  three.Camera? get camera => _camera;

  void setPosition(double x, double y, double z) {
    if (_camera == null) return;
    _camera!.position.setValues(x, y, z);
    notifyListeners();
  }

  void lookAt(double x, double y, double z) {
    if (_camera == null) return;
    _camera!.lookAt(three.Vector3(x, y, z));
    notifyListeners();
  }
}
