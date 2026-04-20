import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_patient_screen.dart';
import 'patient_details_screen.dart';
import 'dart:io';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Map<String, dynamic>> patients = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    setState(() => isLoading = true);

    final data = await DatabaseHelper.instance.getPatients();

    if (!mounted) return;

    setState(() {
      patients = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients"),
        backgroundColor: Colors.teal,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : patients.isEmpty
          ? const Center(child: Text("No patients found"))
          : ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                final photo = patient['photo'];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: (photo != null && photo.toString().isNotEmpty)
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(photo)),
                            radius: 25,
                          )
                        : const CircleAvatar(
                            radius: 25,
                            child: Icon(Icons.person),
                          ),

                    title: Text(patient['name'] ?? 'Unknown'),

                    subtitle: Text("Age: ${patient['age']}"),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PatientDetailsScreen(patient: patient),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPatientScreen()),
          );

          _loadPatients();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
