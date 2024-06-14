import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nebengbro_apps/Users/rangkumanorder.dart';

class NebengScreen extends StatefulWidget {
  final LatLng? startLocation;

  NebengScreen({Key? key, this.startLocation}) : super(key: key);

  @override
  _NebengScreenState createState() => _NebengScreenState();
}

class _NebengScreenState extends State<NebengScreen> {
  String? _startLocationName;
  String? _endLocationName;
  LatLng? _selectedStartLocation;
  LatLng? _selectedEndLocation;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  Set<Polyline> _polylines = {};
  List<LatLng> _routePoints = [];
  bool _selectingStart = true;

  Future<void> _getAddress(LatLng pos, bool isStart) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String streetName = place.street ?? '';
        String subLocality = place.subLocality ?? '';
        String locality = place.locality ?? '';

        setState(() {
          if (isStart) {
            _startLocationName = [streetName, subLocality, locality]
                .where((element) => element.isNotEmpty)
                .join(', ');
          } else {
            _endLocationName = [streetName, subLocality, locality]
                .where((element) => element.isNotEmpty)
                .join(', ');
          }
        });

        _saveToFirebase(pos, isStart);
      } else {
        setState(() {
          if (isStart) {
            _startLocationName = "Unknown location";
          } else {
            _endLocationName = "Unknown location";
          }
        });
      }
    } catch (e) {
      print('Error fetching address: $e');
      setState(() {
        if (isStart) {
          _startLocationName = "Error fetching location";
        } else {
          _endLocationName = "Error fetching location";
        }
      });
    }
  }

  Future<void> _saveToFirebase(LatLng pos, bool isStart) async {
    final DatabaseReference locationRef = isStart
        ? databaseReference.child('locations/start')
        : databaseReference.child('locations/end');

    // Set the new location
    await locationRef.set({
      'latitude': pos.latitude,
      'longitude': pos.longitude,
      'name': isStart ? _startLocationName : _endLocationName,
    });

    // Get directions and draw polyline
    await _getDirectionsAndDrawPolyline();
  }

  Future<void> _getDirectionsAndDrawPolyline() async {
    if (_selectedStartLocation != null && _selectedEndLocation != null) {
      final String apiKey =
          '5b3ce3597851110001cf6248ad6075d234c04030a454e61743a1a792'; // API tracking maps

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
        print('Error fetching directions');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocationsFromFirebase();
  }

  Future<void> _getLocationsFromFirebase() async {
    final DatabaseReference startLocationRef =
        databaseReference.child('locations/start');
    final DatabaseReference endLocationRef =
        databaseReference.child('locations/end');

    final DataSnapshot startSnapshot = await startLocationRef.get();
    final DataSnapshot endSnapshot = await endLocationRef.get();

    if (startSnapshot.exists) {
      final startData = startSnapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _selectedStartLocation =
            LatLng(startData['latitude'], startData['longitude']);
      });
    }

    if (endSnapshot.exists) {
      final endData = endSnapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _selectedEndLocation =
            LatLng(endData['latitude'], endData['longitude']);
      });
    }

    if (_selectedStartLocation != null && _selectedEndLocation != null) {
      _getDirectionsAndDrawPolyline();
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
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      // Change from Row to Column
                      children: [
                        Image.asset(
                          'assets/image/car1.png',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(height: 10), // Spasi antara gambar dan teks
                        Text(
                          'Standard',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('10 min'),
                        Text(
                          'Rp. 15.000',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle the button press
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Rangkumanorder(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pesan Tebeng',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          SizedBox(width: 10),
                          Text('Rp15.000',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                5), // Ubah ukuran tombol (padding vertikal)
                        backgroundColor: Color.fromRGBO(63, 81, 181, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30), // Ubah radius tombol
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
        title: Text('Lokasi Penjemputan'),
        actions: [
          IconButton(
            icon: Icon(_selectingStart ? Icons.location_on : Icons.flag),
            onPressed: () {
              setState(() {
                _selectingStart = !_selectingStart;
              });
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: (controller) {},
        initialCameraPosition: CameraPosition(
          target: _selectedStartLocation ?? LatLng(-8.184486, 113.668076),
          zoom: 15,
        ),
        onTap: (latLng) {
          setState(() {
            if (_selectingStart) {
              _selectedStartLocation = latLng;
              _getAddress(latLng, true);
            } else {
              _selectedEndLocation = latLng;
              _getAddress(latLng, false);
            }
          });
        },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedStartLocation != null && _selectedEndLocation != null) {
            _showBottomSheet(); // Show the bottom sheet when both locations are selected
          } else {
            print('Start or End location is not selected'); // Debug print
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
