import 'package:flutter/material.dart';

class ClinicListScreen extends StatelessWidget {
  final List<Map<String, String>> clinics;

  ClinicListScreen({required this.clinics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clinic List"), backgroundColor: Colors.teal),

      body: clinics.isEmpty
          ? Center(child: Text("No Clinics Added"))
          : ListView.builder(
              itemCount: clinics.length,
              itemBuilder: (context, index) {
                final clinic = clinics[index];

                return Card(
                  margin: EdgeInsets.all(10),

                  child: ListTile(
                    leading: Icon(Icons.local_hospital, color: Colors.teal),

                    title: Text(clinic["name"]!),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location: ${clinic["location"]}"),
                        Text("Phone: ${clinic["phone"]}"),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
