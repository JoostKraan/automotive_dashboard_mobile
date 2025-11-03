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
  final Flutter3DController _controller = Flutter3DController();
  List<String> availableAnimations = [];

  @override
  void initState() {
    super.initState();
  }

  void _setIsometricView() {
    _controller.setCameraOrbit(30, 70, 10);
    _controller.setCameraTarget(0.8, 0.5, 2);
  }

  Future<void> _onModelLoaded(String src) async {
    debugPrint('✅ Model loaded: $src');
    _setIsometricView();
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
            const Divider(
              color: Color.fromARGB(255, 58, 58, 58),
              thickness: 0.3,
            ),
            const Text('Parked', style: TextStyle(color: Colors.white70)),
            Expanded(
              child: Flutter3DViewer(
                controller: _controller,
                src: 'assets/models/EscortAnimationtest.glb',
                enableTouch: false,
                onLoad: _onModelLoaded,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Wrap(
                spacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _controller.playAnimation(animationName: 'left_door');
                    },
                    child: Text('sex'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
