import 'package:flutter/material.dart';
import 'add_clinic_screen.dart';
import 'clinic_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> clinics = [];

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
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddClinicScreen()),
                );

                if (result != null) {
                  setState(() {
                    clinics.add(result);
                  });
                }
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              child: Text("View Clinics"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClinicListScreen(clinics: clinics),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
