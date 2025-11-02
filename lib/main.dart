import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

void main() {
  runApp(const AutomotiveMobileApp());
}

class AutomotiveMobileApp extends StatelessWidget {
  const AutomotiveMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF141819),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 25),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Flutter3DController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Flutter3DController();
  }

  void _setIsometricView() {
    // Set camera to an isometric angle
    _controller.setCameraOrbit(30, 70, 10);
    _controller.setCameraTarget(0.8, 0.5, 2);
  }

  void _rotateLeft() {
    _controller.setCameraOrbit(-90, 0, 5.0);
  }

  void _rotateRight() {
    _controller.setCameraOrbit(90, 0, 5.0);
  }

  void _resetCamera() {
    _setIsometricView();
  }

  void _playAnimation() {
    _controller.playAnimation(
      animationName: "Animation", // change to match your GLB animation name
      loopCount: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141819),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Escort',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('230 km', style: TextStyle(color: Colors.white70)),
              ),
            ),
            const Divider(color: Color.fromARGB(255, 58, 58, 58)),
            const Text('Parked', style: TextStyle(color: Colors.white70)),

            Expanded(
              child: Flutter3DViewer(
                controller: _controller,
                src: 'assets/models/Escorttest.glb',
                enableTouch: false,
                onLoad: (String src) {
                  debugPrint('Model loaded: $src');
                  _setIsometricView();
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _rotateLeft,
                  child: const Text('Rotate Left 90°'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _setIsometricView,
                  child: const Text('Rotate Right 90°'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _playAnimation,
              child: const Text('Play Animation'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
