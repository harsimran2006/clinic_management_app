import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClinicMapScreen extends StatelessWidget {
  //Clinic name passed from the details screen
  final double lat;
  final double lng;
  final String clinicName;

  const ClinicMapScreen({
    super.key,
    required this.lat,
    required this.lng,
    required this.clinicName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(clinicName)),

      //Google map showing the clinic location
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("clinic"),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: clinicName),
          ),
        },
      ),
    );
  }
}
