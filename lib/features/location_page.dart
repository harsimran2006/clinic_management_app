import 'package:flutter/material.dart';
import '../services/location_service.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  dynamic result;

  void fetchLocation() async {
    try {
      var r = await LocationService.determinePosition();
      setState(() {
        result = r;
      });
    } catch (ex) {
      setState(() {
        result = ex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get Location")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: fetchLocation,
              child: Text("Get Current Location"),
            ),
            SizedBox(height: 20),
            Text("${result ?? ''}"),
          ],
        ),
      ),
    );
  }
}
