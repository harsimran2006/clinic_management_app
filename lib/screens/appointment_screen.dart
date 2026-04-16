import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController patientController = TextEditingController();
  TextEditingController clinicController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void saveAppointment() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Appointment Booked Successfully")),
      );

      Navigator.pop(context, {
        "patient": patientController.text.trim(),
        "clinic": clinicController.text.trim(),
        "date": dateController.text.trim(),
      });
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

          child: Column(
            children: [
              Text(
                "Enter Appointment Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              // Patient Name
              TextFormField(
                controller: patientController,
                decoration: InputDecoration(
                  labelText: "Patient Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter patient name";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              // Clinic Name
              TextFormField(
                controller: clinicController,
                decoration: InputDecoration(
                  labelText: "Clinic Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter clinic name";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              // Date
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Appointment Date",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    dateController.text =
                        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                  }
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Select a date";
                  }
                  return null;
                },
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
    );
  }

  @override
  void dispose() {
    patientController.dispose();
    clinicController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
