import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ClinicListScreen extends StatefulWidget {
  const ClinicListScreen({super.key});

  @override
  _ClinicListScreenState createState() => _ClinicListScreenState();
}

class _ClinicListScreenState extends State<ClinicListScreen> {
  List<Map<String, dynamic>> clinics = [];

  @override
  void initState() {
    super.initState();
    loadClinics();
  }

  Future<void> loadClinics() async {
    final data = await DatabaseHelper.instance.getClinics();
    setState(() {
      clinics = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clinic List"),
        backgroundColor: Colors.teal,
      ),

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

                    title: Text(clinic["name"]),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Location: ${clinic["address"]}"),
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
