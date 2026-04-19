import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddClinicScreen extends StatefulWidget {
  const AddClinicScreen({super.key});

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  //Controllers for clinic input
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final description = TextEditingController();

 //Save clinic to the database
 Future<void> saveClinic() async {
  if (!_formKey.currentState!.validate()) return;

  try {
    //Insert clinic into database
    await DatabaseHelper.instance.insertClinic({
      'name': name.text.trim(),
      'address': address.text.trim(),
      'phone': phone.text.trim(),
      'description': description.text.trim(),
    });

    if (!mounted) return;
    //succes message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Clinic added successfully")),
    );

    Navigator.pop(context);

  } catch (e) {
    // Handle duplicate clinic
    if (e.toString().contains("UNIQUE constraint failed")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Clinic already exists"),
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
        title: const Text("Add Clinic"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _field(name, "Clinic Name"),
              _field(address, "Address"),
              _field(phone, "Phone"),
              _field(description, "Description", maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveClinic,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) => v!.isEmpty ? "Enter $label" : null,
      ),
    );
  }
}
