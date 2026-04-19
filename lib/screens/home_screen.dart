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
      //App bar title for the homepage
      appBar: AppBar(title: const Text("Home")),

      //Main menu list with navigation buttons
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _menuButton(context, "Clinics", const ClinicListScreen()), //Takes you to the clinic list screen
          _menuButton(context, "Patients", const PatientListScreen()), //Takes you to the Patient list screen
          _menuButton(context, "Appointments", const AppointmentScreen()),//Takes you to the apppointment screen
          _menuButton(context, "Profile", const ProfileScreen()),//Takes you to the profile screen
        ],
      ),
    );
  }
  //Reuasable button widget for each menu option 
  Widget _menuButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),

        //Pushes the selected page onto the navigation stack
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },

        //Button label
        child: Text(title, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
