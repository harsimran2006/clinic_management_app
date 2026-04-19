import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_clinic_screen.dart';
import 'clinic_details_screen.dart';

class ClinicListScreen extends StatefulWidget {
  const ClinicListScreen({super.key});

  @override
  State<ClinicListScreen> createState() => _ClinicListScreenState();
}

class _ClinicListScreenState extends State<ClinicListScreen> {
  //List to store all clinics from the database
  List<Map<String, dynamic>> clinics = [];

  @override
  void initState() {
    super.initState();
    _loadClinics();
  }

  //Fetch clinics from the database
  Future<void> _loadClinics() async {
    final data = await DatabaseHelper.instance.getClinics();
    setState(() {
      clinics = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clinics")),
      body: ListView.builder(
        itemCount: clinics.length,
        itemBuilder: (context, index) {
          final clinic = clinics[index];
          return Card(
            child: ListTile(
              title: Text(clinic['name']),
              subtitle: Text(clinic['address']),
              //Open details screen when tapped
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClinicDetailsScreen(clinic: clinic),
                  ),
                );
              },
            ),
          );
        },
      ),

      //Button to add a new clinic
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClinicScreen()),
          );
          _loadClinics();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
