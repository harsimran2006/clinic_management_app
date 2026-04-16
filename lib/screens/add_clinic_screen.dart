import 'package:flutter/material.dart';

class AddClinicScreen extends StatefulWidget {
  @override
  _AddClinicScreenState createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void saveClinic() {
    if (_formKey.currentState!.validate()) {
      // Create clinic data
      final clinicData = {
        "name": nameController.text.trim(),
        "location": locationController.text.trim(),
        "phone": phoneController.text.trim(),
      };

      // Show message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Clinic Saved Successfully")));

      // Go back and send data
      Navigator.pop(context, clinicData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Clinic"), backgroundColor: Colors.teal),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              Text(
                "Enter Clinic Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              TextFormField(
                controller: nameController,
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

              TextFormField(
                controller: locationController,
                decoration: InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter location";
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
                    return "Enter a valid 10-digit number";
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),

              ElevatedButton(
                onPressed: saveClinic,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text("Save Clinic", style: TextStyle(fontSize: 16)),
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
    locationController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
