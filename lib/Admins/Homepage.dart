import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Admins/pelamar.dart';
import 'package:nebengbro_apps/Admins/profile.dart';
import 'package:nebengbro_apps/Admins/status.dart';
import 'package:nebengbro_apps/Admins/riwayat.dart';

class HomePage_Admin extends StatefulWidget {
  @override
  _HomePage_AdminState createState() => _HomePage_AdminState();
}

class _HomePage_AdminState extends State<HomePage_Admin> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Widget nextPage;
    if (index == 0) {
      nextPage = HomePage_Admin();
    } else if (index == 1) {
      nextPage = ProfilePage_Admin();
    } else {
      return;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Ingin berpergian dengan gampang? Yukk bersama Nebeng Bro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 100,
                      child: Image.asset(
                        'assets/image/car.png', // Replace with the actual image URL
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Features',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FeatureButton(
                      icon: Icons.favorite,
                      label: 'Pelamar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PelamarPage(),
                          ),
                        );
                      },
                    ),
                    FeatureButton(
                      icon: Icons.lightbulb,
                      label: 'Status',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StatusPage(),
                          ),
                        );
                      },
                    ),
                    FeatureButton(
                      icon: Icons.history,
                      label: 'Riwayat',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RiwayatPage_Admin(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  FeatureButton({required this.icon, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.orange,
              size: 40,
            ),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
