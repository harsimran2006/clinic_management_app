import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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

            // Profile Icon
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

            // Name
            Text(
              "User Name",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            // Email
            Text(
              "user@email.com",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 30),

            // Info Card
            Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.local_hospital, color: Colors.teal),
                title: Text("Total Clinics"),
                trailing: Text("5"),
              ),
            ),

            SizedBox(height: 10),

            Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.teal),
                title: Text("Appointments"),
                trailing: Text("3"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}