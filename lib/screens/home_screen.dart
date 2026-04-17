import 'package:flutter/material.dart';
import 'add_clinic_screen.dart';
import 'clinic_list_screen.dart';
import 'appointment_screen.dart';
import 'add_patient_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: Text("Clinic App"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome 👋",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              child: Text("Add Clinic"),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddClinicScreen()),
                );

                // No need to store clinics locally anymore
                setState(() {});
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("View Clinics"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClinicListScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentScreen()),
                );
              },
              child: Text("Book Appointment"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPatientScreen()),
                );
              },
              child: Text("Add Patient"),
            ),
          ],
        ),
      ),
    );
  }
}
