import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  List<Map<String, dynamic>> clinics = [];
  int? selectedClinicId;

  @override
  void initState() {
    super.initState();
    loadClinics();
  }

  Future<void> loadClinics() async {
    final data = await DatabaseHelper.instance.getClinics();
    setState(() {
      clinics = data;
    });
  }

  void savePatient() async {
    if (_formKey.currentState!.validate()) {
      if (selectedClinicId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please select a clinic")),
        );
        return;
      }

      final patientData = {
        "name": nameController.text.trim(),
        "age": int.parse(ageController.text.trim()),
        "phone": phoneController.text.trim(),
        "email": emailController.text.trim(),
        "clinic_id": selectedClinicId
      };

      await DatabaseHelper.instance.insertPatient(patientData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Patient Added Successfully")),
      );

      Navigator.pop(context);
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
          child: SingleChildScrollView(
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
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? "Enter patient name" : null,
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

                SizedBox(height: 15),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email (optional)",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 15),

                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: "Select Clinic",
                    border: OutlineInputBorder(),
                  ),
                  items: clinics.map((clinic) {
                    return DropdownMenuItem<int>(
                      value: clinic['id'],
                      child: Text(clinic['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClinicId = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? "Please select a clinic" : null,
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
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
