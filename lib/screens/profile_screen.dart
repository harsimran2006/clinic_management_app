import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int totalClinics = 0;
  int totalAppointments = 0;

  @override
  void initState() {
    super.initState();
    loadCounts();
  }

  Future<void> loadCounts() async {
    final clinics = await DatabaseHelper.instance.getClinics();
    final appointments = await DatabaseHelper.instance.getAppointments();

    setState(() {
      totalClinics = clinics.length;
      totalAppointments = appointments.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "User Name",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "user@email.com",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.teal),
                title: const Text("Total Clinics"),
                trailing: Text(totalClinics.toString()),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.calendar_today, color: Colors.teal),
                title: const Text("Appointments"),
                trailing: Text(totalAppointments.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
