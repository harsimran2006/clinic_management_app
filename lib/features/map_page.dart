import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const API_KEY = "i4yL2XdZNYi0l2WGM6hj";

class MapPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String title;

  const MapPage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final point = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.teal),

      body: FlutterMap(
        options: MapOptions(initialCenter: point, initialZoom: 16),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=$API_KEY",
            userAgentPackageName: "com.example.clinic_app",
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: point,
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
