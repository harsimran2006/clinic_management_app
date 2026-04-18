import 'package:flutter/material.dart';

class ClinicDetailsScreen extends StatelessWidget {
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

            const Text(
              "Address:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['address'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              "Phone:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['phone'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              "Description:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              clinic['description'] ?? "No description provided",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
