import 'package:flutter/material.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void savePatient() {
    if (_formKey.currentState!.validate()) {
      final patientData = {
        "name": nameController.text.trim(),
        "age": ageController.text.trim(),
        "phone": phoneController.text.trim(),
      };

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Patient Added Successfully")));

      Navigator.pop(context, patientData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Patient"), backgroundColor: Colors.teal),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Enter Patient Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: nameController,
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

              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter age";
                  }
                  final age = int.tryParse(value);
                  if (age == null || age <= 0) {
                    return "Enter a valid number";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter phone number";
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return "Enter valid 10-digit number";
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),

              ElevatedButton(
                onPressed: savePatient,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Save Patient"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
