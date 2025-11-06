import 'package:automotive_dashboard_mobile/controllers/camera_controller.dart';
import 'package:automotive_dashboard_mobile/layout/3d_carmodel_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/action_button_row_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/car_stats_widget.dart';
import 'package:automotive_dashboard_mobile/widgets/top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  MapboxOptions.setAccessToken(dotenv.env["MAPBOX_TOKEN"]!);
  runApp(
    ChangeNotifierProvider(
      create: (_) => CameraController(),
      child: const AutomotiveMobileApp(),
    ),
  );
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
          headlineMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(
            color: Color.fromARGB(255, 139, 139, 139),
            fontSize: 12,
          ),
          bodySmall: TextStyle(color: Colors.white, fontSize: 14),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 22),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171716),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBarWidget(),
              Divider(color: Color.fromARGB(255, 58, 58, 58), thickness: 0.3),
              CarModelWidget(),
              Divider(color: Color.fromARGB(255, 58, 58, 58), thickness: 0.3),
              CarStatsWidget(),
              ActionButtonRowWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
