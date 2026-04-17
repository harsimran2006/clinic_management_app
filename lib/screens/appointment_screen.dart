import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> clinics = [];
  List<Map<String, dynamic>> patients = [];

  int? selectedClinicId;
  int? selectedPatientId;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    clinics = await DatabaseHelper.instance.getClinics();
    patients = await DatabaseHelper.instance.getPatients();
    setState(() {});
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      timeController.text = pickedTime.format(context);
    }
  }

  void saveAppointment() async {
    if (_formKey.currentState!.validate()) {
      if (selectedClinicId == null || selectedPatientId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select clinic and patient")),
        );
        return;
      }

      final appointmentData = {
        "clinic_id": selectedClinicId,
        "patient_id": selectedPatientId,
        "date": dateController.text.trim(),
        "time": timeController.text.trim(),
        "reason": reasonController.text.trim(),
      };

      await DatabaseHelper.instance.insertAppointment(appointmentData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Appointment Booked Successfully")),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Appointment"),
        backgroundColor: Colors.teal,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Enter Appointment Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                // Patient Dropdown
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Select Patient",
                    border: OutlineInputBorder(),
                  ),
                  items: patients.map((p) {
                    return DropdownMenuItem<int>(
                      value: p['id'] as int,
                      child: Text(p['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPatientId = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Select a patient" : null,
                ),

                SizedBox(height: 15),

                // Clinic Dropdown
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Select Clinic",
                    border: OutlineInputBorder(),
                  ),
                  items: clinics.map((c) {
                    return DropdownMenuItem<int>(
                      value: c['id'] as int,
                      child: Text(c['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClinicId = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Select a clinic" : null,
                ),

                SizedBox(height: 15),

                // Date Picker
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Appointment Date",
                    border: OutlineInputBorder(),
                  ),
                  onTap: pickDate,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Select a date" : null,
                ),

                SizedBox(height: 15),

                // Time Picker
                TextFormField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Appointment Time",
                    border: OutlineInputBorder(),
                  ),
                  onTap: pickTime,
                  validator: (value) =>
                      value == null || value.isEmpty ? "Select a time" : null,
                ),

                SizedBox(height: 15),

                // Reason
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(
                    labelText: "Reason (optional)",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 25),

                ElevatedButton(
                  onPressed: saveAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  child: Text("Book Appointment", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
