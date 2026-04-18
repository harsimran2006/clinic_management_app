import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_patient_screen.dart';
import 'patient_details_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  List<Map<String, dynamic>> patients = [];

  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  Future<void> _loadPatients() async {
    final data = await DatabaseHelper.instance.getPatients();
    setState(() {
      patients = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patients")),
      body: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Card(
            child: ListTile(
              title: Text(patient['name']),
              subtitle: Text("Age: ${patient['age']}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientDetailsScreen(patient: patient),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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
