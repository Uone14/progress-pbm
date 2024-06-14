import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nebengbro_apps/Users/maps.dart';
import 'package:nebengbro_apps/Users/nebeng.dart';
import 'package:nebengbro_apps/Users/Profilpage.dart';
import 'package:nebengbro_apps/Users/ChatPage.dart';
import 'package:nebengbro_apps/Users/topup.dart';
import 'package:nebengbro_apps/Users/riwayat.dart';

class HomePage_User extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage_User> {
  int _selectedIndex = 0;
  String? _locationName = "Choose Location";
  LatLng _selectedLocation = LatLng(0, 0);
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _getAddress(LatLng pos) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String streetName = place.street ?? '';
        String subLocality = place.subLocality ?? '';
        String locality = place.locality ?? '';

        setState(() {
          _locationName = [streetName, subLocality, locality]
              .where((element) => element.isNotEmpty)
              .join(', ');
        });

        _saveToFirebase(pos);
      } else {
        setState(() {
          _locationName = "Unknown location";
        });
      }
    } catch (e) {
      print('Error fetching address: $e');
      setState(() {
        _locationName = "Choose Location";
      });
    }
  }

  Future<void> _saveToFirebase(LatLng pos) async {
    final DatabaseReference endLocationRef =
        databaseReference.child('locations/end');

    await endLocationRef.set({
      'latitude': pos.latitude,
      'longitude': pos.longitude,
      'name': _locationName,
    });
  }

  void _navigateToNebeng() async {
    // ignore: unnecessary_null_comparison
    if (_selectedLocation != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NebengScreen(
            startLocation: _selectedLocation,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please choose a starting location first.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        HomeScreen(
          onPickLocation: (LatLng location, String locationName) {
            setState(() {
              _selectedLocation = location;
              _locationName = locationName;
            });
          },
          onNavigateToNebeng: _navigateToNebeng,
          locationName: _locationName,
        ),
        ChatPage(),
        ProfilePage(),
      ][_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(63, 81, 181, 1),  // Warna item yang dipilih
        unselectedItemColor: Colors.grey,  // Warna item yang tidak dipilih
        selectedIconTheme: IconThemeData(color: Color.fromRGBO(63, 81, 181, 1), size: 30),  // Tema ikon saat dipilih
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25),  // Tema ikon saat tidak dipilih
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Function(LatLng, String) onPickLocation;
  final VoidCallback onNavigateToNebeng;
  final String? locationName;

  HomeScreen({
    required this.onPickLocation,
    required this.onNavigateToNebeng,
    this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    void navigateToRiwayat() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RiwayatPage(),
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final LatLng? result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapSample(),
                              ),
                            );

                            if (result != null) {
                              String locationName =
                                  await getLocationName(result);
                              onPickLocation(result, locationName);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    locationName ?? "Choose Location",
                                    style: const TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Ingin berpergian dengan gampang? Yuk bersama Nebeng Bro",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/image/car.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(63, 81, 181, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.account_balance_wallet, color: Colors.white),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("NebengPay", style: TextStyle(color: Colors.white)),
                      Text(
                        "Rp 30.000",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopUpPage(),
                        ),
                      );
                    },
                    child: const Text("Top Up"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Pay"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FeatureButton(
                icon: Icons.favorite,
                label: "Nebeng",
                onTap: onNavigateToNebeng,
              ),
              FeatureButton(
                icon: Icons.history,
                label: "Riwayat",
                onTap: navigateToRiwayat,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<String> getLocationName(LatLng pos) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String streetName = place.street ?? '';
        String subLocality = place.subLocality ?? '';
        String locality = place.locality ?? '';

        return [streetName, subLocality, locality]
            .where((element) => element.isNotEmpty)
            .join(', ');
      } else {
        return "Unknown location";
      }
    } catch (e) {
      print('Error fetching address: $e');
      return "Choose Location";
    }
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  FeatureButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 30, color: Colors.white),
            backgroundColor: Color.fromRGBO(63,81,181,1),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
