import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  //List to store patients and clinic from the database
  List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> clinics = [];

  //Selected dropdown values
  int? selectedPatient;
  int? selectedClinic;
 
  //Selected date and time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  
  //Controller for the reason text field
  final reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData(); //load patients and clinics when screen opens
  }
  
  //Fetch patients and clients from the database
  Future<void> loadData() async {
    patients = await DatabaseHelper.instance.getPatients();
    clinics = await DatabaseHelper.instance.getClinics();
    setState(() {});
  }
 
  //Open date picker
  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) setState(() => selectedDate = date);
  }
  
  //Open time picker
  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => selectedTime = time);
  }

  //Validate and save appointment to the database
  Future<void> saveAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    //Ensure dropdowns are selected
    if (selectedPatient == null || selectedClinic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select patient and clinic")),
      );
      return;
    }
    
    //Ensure date and time are selected
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time")),
      );
      return;
    }
    
    //Format date and time
    final dateStr =
        "${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}";
    final timeStr =
        "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}";

    //Insert appointment into database
    await DatabaseHelper.instance.insertAppointment({
      'patient_id': selectedPatient,
      'clinic_id': selectedClinic,
      'date': dateStr,
      'time': timeStr,
      'reason': reasonController.text.trim(),
    });

    if (!mounted) return;
    
    //Show confirmation message
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Appointment added")));

    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Appointment"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              //Patient dropdown
              DropdownButtonFormField<int>(
                initialValue: selectedPatient,
                decoration: const InputDecoration(
                  labelText: "Select Patient",
                  border: OutlineInputBorder(),
                ),
                items: patients.map((p) {
                  return DropdownMenuItem<int>(
                    value: p['id'] as int,
                    child: Text(p['name']),
                  );
                }).toList(),
                onChanged: (v) => setState(() => selectedPatient = v),
                validator: (v) => v == null ? "Please select a patient" : null,
              ),
              const SizedBox(height: 15),
              
              //Clinic dropdown button
              DropdownButtonFormField<int>(
                initialValue: selectedClinic,
                decoration: const InputDecoration(
                  labelText: "Select Clinic",
                  border: OutlineInputBorder(),
                ),
                items: clinics.map((c) {
                  return DropdownMenuItem<int>(
                    value: c['id'] as int,
                    child: Text(c['name']),
                  );
                }).toList(),
                onChanged: (v) => setState(() => selectedClinic = v),
                validator: (v) => v == null ? "Please select a clinic" : null,
              ),
              const SizedBox(height: 15),
              
              //Date Picker button
              ElevatedButton(
                onPressed: pickDate,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: Text(
                  selectedDate == null
                      ? "Pick Date"
                      : "Date: ${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}",
                ),
              ),
              const SizedBox(height: 15),

              //Time picker button
              ElevatedButton(
                onPressed: pickTime,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: Text(
                  selectedTime == null
                      ? "Pick Time"
                      : "Time: ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}",
                ),
              ),
              const SizedBox(height: 15),

              //Reason text field
              TextFormField(
                controller: reasonController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Reason",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              //Save button
              ElevatedButton(
                onPressed: saveAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Save Appointment"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
