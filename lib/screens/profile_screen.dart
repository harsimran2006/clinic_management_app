import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
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
        title: Text("Profile"),
        backgroundColor: Colors.teal,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "User Name",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "user@email.com",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 30),

            Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.local_hospital, color: Colors.teal),
                title: Text("Total Clinics"),
                trailing: Text(totalClinics.toString()),
              ),
            ),

            SizedBox(height: 10),

            Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.teal),
                title: Text("Appointments"),
                trailing: Text(totalAppointments.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
