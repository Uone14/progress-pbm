import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nebengbro_apps/Drivers/dompet1.dart';
import 'package:nebengbro_apps/Drivers/profile.dart';
import 'package:nebengbro_apps/Drivers/message.dart';
import 'package:nebengbro_apps/Drivers/map_driver.dart';

// ignore: camel_case_types
class Beranda_Driver extends StatefulWidget {
  final String? username;

  const Beranda_Driver({super.key, required this.username});

  @override
  // ignore: library_private_types_in_public_api
  _Beranda_DriverState createState() => _Beranda_DriverState();
}

// ignore: camel_case_types
class _Beranda_DriverState extends State<Beranda_Driver> {
  int _selectedIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomeScreen(username: widget.username),
      PendapatanScreen1(),
      TextMessageScreen(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.home, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.account_balance_wallet, 1),
            label: "Dompet",
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.chat, 2),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.person, 3),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(63, 81, 181, 1),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildAnimatedIcon(IconData icon, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _selectedIndex == index ? 35 : 25,
      height: _selectedIndex == index ? 35 : 25,
      child: Icon(
        icon,
        color: _selectedIndex == index ? const Color.fromRGBO(63, 81, 181, 1) : Colors.grey,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String? username;

  const HomeScreen({super.key, required this.username});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> taxiServices = [
    {
      'name': 'Evan',
      'rating': 4.9,
      'pickupLocation': 'Matahari Royal Plaza',
      'price': 20000,
      'date': '13 Apr, 18:07',
    },
    {
      'name': 'Theresa',
      'rating': 4.5,
      'pickupLocation': 'Jember Roxy Square',
      'price': 15000,
      'date': '13 Apr, 16:45',
    },
    {
      'name': 'Mustofa',
      'rating': 4.8,
      'pickupLocation': 'Aston Jember Hotel',
      'price': 35000,
      'date': '13 Apr, 14:30',
    },
    {
      'name': 'Kezia',
      'rating': 4.7,
      'pickupLocation': 'Lippo Plaza Jember',
      'price': 15000,
      'date': '13 Apr, 13:15',
    },
  ];

  List<String> destinations = List.filled(4, 'Loading...');

  @override
  void initState() {
    super.initState();
    _fetchDestinations();
  }

  Future<void> _fetchDestinations() async {
    for (int i = 0; i < taxiServices.length; i++) {
      String destination = await _fetchDestination();
      setState(() {
        destinations[i] = destination;
      });
    }
  }

  Future<String> _fetchDestination() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('locations/end/name');
    DatabaseEvent event = await ref.once();
    return event.snapshot.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color.fromARGB(255, 252, 252, 252),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 76, 138, 211),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(191, 231, 49, 1),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            ),
                            child: const Text('Online'),
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              side: const BorderSide(color: Color.fromRGBO(191, 231, 49, 1)),
                            ),
                            child: const Text('Offline', style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/image/car.png',
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: taxiServices.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman detail atau chat jika diperlukan
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TextMessageScreen()),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.9, // Set the container's width to 90% of the screen's width
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              taxiServices[index]['date'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                  child: const Icon(Icons.person, size: 30, color: Colors.blue),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      taxiServices[index]['pickupLocation'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: <Widget>[
                                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                                        const SizedBox(width: 5),
                                        Text(
                                          taxiServices[index]['rating'].toString(),
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  'Rp${taxiServices[index]['price']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.location_on, color: Colors.green, size: 30),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    destinations[index],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    // Navigasi ke halaman peta ketika ikon diklik
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Maps_Drivers()),
                                    );
                                  },
                                  child: const Icon(Icons.map, color: Colors.blue, size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
