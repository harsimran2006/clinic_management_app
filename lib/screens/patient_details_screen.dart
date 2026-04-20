import 'package:flutter/material.dart';
import 'dart:io';

class PatientDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const PatientDetailsScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final photoPath = patient['photo'];

    return Scaffold(
      appBar: AppBar(
        title: Text(patient['name'] ?? "Patient"),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: (photoPath != null && photoPath.toString().isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(photoPath),
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.person, size: 120),
            ),

            const SizedBox(height: 20),

            Text(
              "Name: ${patient['name']}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Age: ${patient['age']}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Phone: ${patient['phone']}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Email: ${patient['email'] ?? 'No email provided'}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
