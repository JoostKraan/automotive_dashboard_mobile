import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

class CarMap extends StatefulWidget {
  const CarMap({super.key});

  @override
  State<CarMap> createState() => _CarMapState();
}

class _CarMapState extends State<CarMap> {
  MapboxMap? mapboxMap;
  PointAnnotationManager? pointAnnotationManager;
  bool _isMapReady = false;
  bool _showRecenterButton = true;
  geo.Position? _userPosition;

  final double latitude = 52.9925;
  final double longitude = 6.5649;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171716),
      appBar: AppBar(
        backgroundColor: const Color(0xFF171716),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Vehicle Location',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          MapWidget(
            cameraOptions: CameraOptions(
              center: Point(coordinates: Position(longitude, latitude)),
              zoom: 15.0,
            ),
            styleUri: MapboxStyles.DARK,
            onMapCreated: _onMapCreated,
          ),

          if (_showRecenterButton)
            Positioned(
              right: 15,
              top: 10,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: const Color(0xFF1E1E1E),
                onPressed: _recenterCamera,
                child: Icon(
                  Icons.my_location,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2D2E), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Parked',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time_rounded,
                        size: 16,
                        color: Colors.white.withOpacity(0.5),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '12m ago',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Nieuw Moscou, Drenthe',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.ev_station,
                          label: 'Fuel',
                          value: '34%',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoItem(
                          icon: Icons.thermostat,
                          label: 'Temp',
                          value: '21°C',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onMapCreated(MapboxMap map) async {
    mapboxMap = map;

    await mapboxMap?.logo.updateSettings(LogoSettings(enabled: false));
    await mapboxMap?.attribution.updateSettings(
      AttributionSettings(enabled: false),
    );
    await mapboxMap?.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

    var status = await Permission.location.request();

    if (status.isGranted) {
      await mapboxMap?.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true),
      );

      try {
        geo.Position position = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high,
        );

        _userPosition = position;

        await mapboxMap?.flyTo(
          CameraOptions(
            center: Point(
              coordinates: Position(position.longitude, position.latitude),
            ),
            zoom: 15.0,
          ),
          MapAnimationOptions(duration: 2000),
        );
      } catch (e) {
        print('Error getting location: $e');
      }
    } else {
      print('Location permission denied');
    }

    pointAnnotationManager = await map.annotations
        .createPointAnnotationManager();

    await _addCarMarker();

    if (mounted) {
      setState(() {
        _isMapReady = true;
      });
    }
  }

  Future<void> _addCarMarker() async {
    if (pointAnnotationManager == null) return;

    final pointAnnotationOptions = PointAnnotationOptions(
      geometry: Point(coordinates: Position(longitude, latitude)),
      iconSize: 1.5,
      iconImage: "car",
    );

    await pointAnnotationManager!.create(pointAnnotationOptions);
  }

  Future<void> _recenterCamera() async {
    if (mapboxMap == null || _userPosition == null) return;

    await mapboxMap?.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(
            _userPosition!.longitude,
            _userPosition!.latitude,
          ),
        ),
        zoom: 15.0,
      ),
      MapAnimationOptions(duration: 1000),
    );
  }

  @override
  void dispose() {
    pointAnnotationManager?.deleteAll();
    super.dispose();
  }
}
