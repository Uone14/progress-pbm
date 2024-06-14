import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:nebengbro_apps/Drivers/Order_Driver.dart';
import 'dart:convert';
import 'package:nebengbro_apps/Users/rangkumanorder.dart';

class Maps_Drivers extends StatefulWidget {
  @override
  _Maps_DriversState createState() => _Maps_DriversState();
}

class _Maps_DriversState extends State<Maps_Drivers> {
  String? _startLocationName;
  String? _endLocationName;
  LatLng? _selectedStartLocation;
  LatLng? _selectedEndLocation;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  Set<Polyline> _polylines = {};
  List<LatLng> _routePoints = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocationsFromFirebase();
  }

  Future<void> _getLocationsFromFirebase() async {
    try {
      final DatabaseReference startLocationRef =
          databaseReference.child('locations/start');
      final DatabaseReference endLocationRef =
          databaseReference.child('locations/end');

      final DataSnapshot startSnapshot = await startLocationRef.get();
      final DataSnapshot endSnapshot = await endLocationRef.get();

      if (startSnapshot.exists) {
        final startData = startSnapshot.value as Map<dynamic, dynamic>;
        _selectedStartLocation =
            LatLng(startData['latitude'], startData['longitude']);
        _startLocationName = startData['name'];
      }

      if (endSnapshot.exists) {
        final endData = endSnapshot.value as Map<dynamic, dynamic>;
        _selectedEndLocation =
            LatLng(endData['latitude'], endData['longitude']);
        _endLocationName = endData['name'];
      }

      if (_selectedStartLocation != null && _selectedEndLocation != null) {
        await _getDirectionsAndDrawPolyline();
        _showBottomSheet();
      }
    } catch (e) {
      print('Error fetching locations from Firebase: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getDirectionsAndDrawPolyline() async {
    if (_selectedStartLocation != null && _selectedEndLocation != null) {
      try {
        final String apiKey =
            '5b3ce3597851110001cf6248ad6075d234c04030a454e61743a1a792'; // Replace with your OpenRouteService API key

        final response = await http.get(
          Uri.parse(
              'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${_selectedStartLocation!.longitude},${_selectedStartLocation!.latitude}&end=${_selectedEndLocation!.longitude},${_selectedEndLocation!.latitude}'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          final coordinates = data['features'][0]['geometry']['coordinates'];
          setState(() {
            _routePoints = coordinates
                .map<LatLng>((point) => LatLng(point[1], point[0]))
                .toList();

            _polylines = {
              Polyline(
                polylineId: PolylineId('route'),
                points: _routePoints,
                color: Color.fromARGB(255, 50, 31, 118),
                width: 5,
              ),
            };
          });
        } else {
          print('Error fetching directions: ${response.body}');
        }
      } catch (e) {
        print('Error fetching directions: $e');
      }
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return LayoutBuilder(
              builder: (context, constraints) {
                double height = MediaQuery.of(context).size.height;
                double width = MediaQuery.of(context).size.width;
                
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/image/car1.png'),
                          ),
                          title: Text('Kezia', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              Text('4.7 (10)'),
                            ],
                          ),
                          trailing: Text('Rp15.000', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        ListTile(
                          leading: Icon(Icons.location_on, color: Colors.blue),
                          title: Text('Universitas Jember'),
                          subtitle: Text('13 Apr, 13:19'),
                        ),
                        ListTile(
                          leading: Icon(Icons.location_on, color: Colors.red),
                          title: Text('Lippo Plaza Jember'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDrivers(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Terima dengan harga Rp15.000',
                                  style: TextStyle(fontSize: height * 0.02, color: Colors.white), // Adjust fontSize based on screen height
                                ),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: height * 0.02), // Adjust vertical padding based on screen height
                              backgroundColor: Color.fromRGBO(63, 81, 181, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permintaan transportasi'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {},
              initialCameraPosition: CameraPosition(
                target: _selectedStartLocation ?? LatLng(-8.184486, 113.668076),
                zoom: 15,
              ),
              markers: {
                if (_selectedStartLocation != null)
                  Marker(
                    markerId: MarkerId('start-location'),
                    position: _selectedStartLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                  ),
                if (_selectedEndLocation != null)
                  Marker(
                    markerId: MarkerId('end-location'),
                    position: _selectedEndLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                  ),
              },
              polylines: _polylines,
            ),
    );
  }
}
