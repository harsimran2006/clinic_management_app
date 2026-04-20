import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_clinic_screen.dart';
import 'clinic_details_screen.dart';
import 'clinic_map_screen.dart';

class ClinicListScreen extends StatefulWidget {
  const ClinicListScreen({super.key});

  @override
  State<ClinicListScreen> createState() => _ClinicListScreenState();
}

class _ClinicListScreenState extends State<ClinicListScreen> {
  List<Map<String, dynamic>> clinics = [];

  @override
  void initState() {
    super.initState();
    _loadClinics();
  }

  Future<void> _loadClinics() async {
    final data = await DatabaseHelper.instance.getClinics();
    setState(() {
      clinics = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clinics"),
        backgroundColor: Colors.teal,
      ),

      body: clinics.isEmpty
          ? const Center(child: Text("No clinics found"))
          : ListView.builder(
              itemCount: clinics.length,
              itemBuilder: (context, index) {
                final clinic = clinics[index];

                final double? lat = double.tryParse(
                  clinic['latitude']?.toString() ?? '',
                );
                final double? lng = double.tryParse(
                  clinic['longitude']?.toString() ?? '',
                );

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: const Icon(
                      Icons.local_hospital,
                      color: Colors.teal,
                    ),

                    title: Text(
                      clinic['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clinic['address']),
                        Text("Phone: ${clinic['phone']}"),

                        const SizedBox(height: 5),

                        // Map button (only if coords exist)
                        if (lat != null && lng != null)
                          TextButton(
                            onPressed: () {
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
                            },
                            child: const Text("View on Map"),
                          ),
                      ],
                    ),

                    // Tap → details screen
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ClinicDetailsScreen(clinic: clinic),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClinicScreen()),
          );
          _loadClinics();
        },
      ),
    );
  }
}
