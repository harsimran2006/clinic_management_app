import 'package:flutter/material.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient['name']),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patient['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Age:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              patient['age'].toString(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              "Phone:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              patient['phone'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              "Email:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              patient['email'] ?? "No email provided",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
