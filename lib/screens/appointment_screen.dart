import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'add_appointment_screen.dart';
import 'appointment_details_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  //List to store all appointments with patient and clinic names
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    loadAppointments(); //load appointments when screen open
  }

  //Fetch appointments from database
  Future<void> loadAppointments() async {
    appointments = await DatabaseHelper.instance.getAppointmentsWithNames();
    setState(() {});
  }

  //Refresh list after adding a new appointment
  Future<void> refreshAfterAdd() async {
    await loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        backgroundColor: Colors.teal,
      ),

      body: appointments.isEmpty
          ? const Center(child: Text("No appointments found"))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final a = appointments[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      "${a['patient_name']} → ${a['clinic_name']}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Date: ${a['date']}   Time: ${a['time']}",
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailsScreen(
                            appointment: a,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

      //Button to add a new appointment
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAppointmentScreen()),
          );
          refreshAfterAdd();
        },
      ),
    );
  }
}
