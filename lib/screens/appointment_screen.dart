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
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  Future<void> _loadAppointments() async {
    final data = await DatabaseHelper.instance.getAppointments();
    setState(() {
      appointments = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final a = appointments[index];
          return Card(
            child: ListTile(
              title: Text("Appointment ${a['id']}"),
              subtitle: Text("${a['date']} at ${a['time']}"),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddAppointmentScreen()),
          );
          _loadAppointments(); // refresh after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
