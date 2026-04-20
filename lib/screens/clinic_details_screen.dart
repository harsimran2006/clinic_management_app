import 'package:flutter/material.dart';
import 'clinic_map_screen.dart';

class ClinicDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> clinic;

  const ClinicDetailsScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    // Safely parse latitude & longitude
    final double? lat = double.tryParse(clinic['latitude']?.toString() ?? '');
    final double? lng = double.tryParse(clinic['longitude']?.toString() ?? '');

    return Scaffold(
      appBar: AppBar(title: Text(clinic['name']), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              clinic['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Address
            const Text(
              "Address:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(clinic['address'], style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // Phone
            const Text(
              "Phone:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(clinic['phone'], style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // Description
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['description'] ?? "No description provided",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // Coordinates (NEW)
            if (lat != null && lng != null) ...[
              const Text(
                "Coordinates:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text("Latitude: $lat"),
              Text("Longitude: $lng"),
            ],

            const Spacer(),

            // Map Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (lat != null && lng != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ClinicMapScreen(
                              lat: lat,
                              lng: lng,
                              clinicName: clinic['name'],
                            ),
                          ),
                        );
                      }
                    : null, // disables button if no coords
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text("View on Map"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
