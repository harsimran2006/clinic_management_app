import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  //Controllers for patient input field
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final age = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
 //Save patient into database
 Future<void> savePatient() async {
  if (!_formKey.currentState!.validate()) return;

  try {
    await DatabaseHelper.instance.insertPatient({
      'name': name.text.trim(),
      'age': int.tryParse(age.text.trim()) ?? 0,
      'phone': phone.text.trim(),
      'email': email.text.trim(),
      'clinic_id': null,
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Patient added successfully")),
    );

    Navigator.pop(context);

  } catch (e) {
    // Handle duplicate patient
    if (e.toString().contains("UNIQUE constraint failed")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Patient already exists"),
        ),
      );
    } else {
      // Any other unexpected error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Patient"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _field(name, "Name"),
              _field(age, "Age", isNumber: true),
              _field(phone, "Phone", isPhone: true),
              _field(email, "Email", isEmail: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: savePatient,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String label, {
    bool isNumber = false,
    bool isPhone = false,
    bool isEmail = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: c,
        keyboardType: isNumber
            ? TextInputType.number
            : isPhone
            ? TextInputType.phone
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) {
          if (v == null || v.trim().isEmpty) {
            return "Enter $label";
          }

          if (isNumber) {
            final num = int.tryParse(v);
            if (num == null) return "Enter a valid number";
            if (num <= 0 || num > 120) return "Enter valid age";
          }

          if (isPhone) {
            if (!RegExp(r'^[0-9]{10}$').hasMatch(v)) {
              return "Enter valid 10-digit number";
            }
          }

          if (isEmail) {
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
              return "Enter valid email";
            }
          }

          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }
}
