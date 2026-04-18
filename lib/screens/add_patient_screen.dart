import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final age = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();

  Future<void> savePatient() async {
    if (!_formKey.currentState!.validate()) return;

    await DatabaseHelper.instance.insertPatient({
      'name': name.text.trim(),
      'age': int.parse(age.text.trim()),
      'phone': phone.text.trim(),
      'email': email.text.trim(),
      'clinic_id': null,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Patient added")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Patient"), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _field(name, "Name"),
              _field(age, "Age"),
              _field(phone, "Phone"),
              _field(email, "Email"),
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

  Widget _field(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) => v!.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
