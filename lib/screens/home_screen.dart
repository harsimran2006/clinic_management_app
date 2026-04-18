import 'package:flutter/material.dart';
import 'clinic_list_screen.dart';
import 'patient_list_screen.dart';
import 'appointment_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _menuButton(context, "Clinics", const ClinicListScreen()),
          _menuButton(context, "Patients", const PatientListScreen()),
          _menuButton(context, "Appointments", const AppointmentScreen()),
          _menuButton(context, "Profile", const ProfileScreen()),
        ],
      ),
    );
  }

  Widget _menuButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
