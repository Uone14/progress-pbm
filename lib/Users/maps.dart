import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_database/firebase_database.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  String? _locationName;
  LatLng? _selectedLocation;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  Future<void> _getAddress(LatLng pos) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String streetName = place.street ?? '';
        String subLocality = place.subLocality ?? '';
        String locality = place.locality ?? '';

        if (mounted) {
          setState(() {
            _locationName = [streetName, subLocality, locality]
                .where((element) => element.isNotEmpty)
                .join(', ');
          });
        }

        _saveToFirebase(pos);
      } else {
        if (mounted) {
          setState(() {
            _locationName = "Unknown location";
          });
        }
      }
    } catch (e) {
      print('Error fetching address: $e');
      if (mounted) {
        setState(() {
          _locationName = "Error fetching location";
        });
      }
    }
  }

  Future<void> _saveToFirebase(LatLng pos) async {
    final DatabaseReference startLocationRef =
        databaseReference.child('locations/end');

    // Set the new "home" location
    await startLocationRef.set({
      'latitude': pos.latitude,
      'longitude': pos.longitude,
      'name': _locationName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Lokasi'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {},
        initialCameraPosition: CameraPosition(
          target: LatLng(-8.184486, 113.668076),
          zoom: 15,
        ),
        onTap: (latLng) {
          setState(() {
            _selectedLocation = latLng;
          });
          _getAddress(latLng);
        },
        markers: _selectedLocation != null
            ? {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: _selectedLocation!,
                ),
              }
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedLocation != null) {
            Navigator.pop(context, _selectedLocation);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
