import 'package:flutter/material.dart';
import 'clinic_map_screen.dart'; //Map screen for viewing clinic location

class ClinicDetailsScreen extends StatelessWidget {
  //Clini data passed from the list screen
  final Map<String, dynamic> clinic;

  const ClinicDetailsScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clinic['name']),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              clinic['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            //adress section
            const Text(
              "Address:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['address'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

           //Phone section
            const Text(
              "Phone:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['phone'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

           //Description aection
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['description'] ?? "No description provided",
              style: const TextStyle(fontSize: 16),
            ),

            const Spacer(),

            // Button to open the map screen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ClinicMapScreen(
                        lat: 43.4643,   // TEMP: Waterloo latitude
                        lng: -80.5204, // TEMP: Waterloo longitude
                        clinicName: clinic['name'],
                      ),
                    ),
                  );
                },
                child: const Text("View on Map"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
