import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  //Appointment data passed from the list screen
  final Map<String, dynamic> appointment;

  const AppointmentDetailsScreen({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointment Details"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${appointment['patient_name']} — ${appointment['clinic_name']}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

          //Patient Section
            const Text(
              "Patient:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              appointment['patient_name'] ?? "Unknown",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            //Clini section
            const Text(
              "Clinic:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              appointment['clinic_name'] ?? "Unknown",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

           //Date section
            const Text(
              "Date:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              appointment['date'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            //Time section
            const Text(
              "Time:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              appointment['time'],
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            const Text(
              "Reason:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              appointment['reason'] ?? "No reason provided",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
