import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../services/location_service.dart';

class AddClinicScreen extends StatefulWidget {
  const AddClinicScreen({super.key});

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final description = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();

  Future<void> saveClinic() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await DatabaseHelper.instance.insertClinic({
        'name': name.text.trim(),
        'address': address.text.trim(),
        'phone': phone.text.trim(),
        'description': description.text.trim(),
        'latitude': latitude.text.trim(),
        'longitude': longitude.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Clinic added successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      if (e.toString().contains("UNIQUE constraint failed")) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Clinic already exists")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  Future<void> getLocation() async {
    try {
      var pos = await LocationService.determinePosition();

      if (!mounted) return;

      setState(() {
        latitude.text = pos.latitude.toString();
        longitude.text = pos.longitude.toString();
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
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
              _field(phone, "Phone", isPhone: true),
              _field(description, "Description", maxLines: 3),

              _field(latitude, "Latitude", readOnly: true),
              _field(longitude, "Longitude", readOnly: true),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: getLocation,
                child: const Text("Get Current Location"),
              ),

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

  Widget _field(
    TextEditingController c,
    String label, {
    int maxLines = 1,
    bool readOnly = false,
    bool isPhone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: c,
        maxLines: maxLines,
        readOnly: readOnly,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) {
          if (v == null || v.trim().isEmpty) {
            return "Enter $label";
          }

          if (isPhone && !RegExp(r'^[0-9]{10}$').hasMatch(v)) {
            return "Enter valid 10-digit number";
          }

          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    phone.dispose();
    description.dispose();
    latitude.dispose();
    longitude.dispose();
    super.dispose();
  }
}
