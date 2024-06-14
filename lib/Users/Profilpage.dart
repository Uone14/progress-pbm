import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Users/editdata.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Handle settings button tap
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/image/profil.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Kerin',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'kerinbello123@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '+62 123456789',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Account'),
              subtitle: Text('Change name, update password, delete account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditDataScreen_User()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text('Pesanan'),
              subtitle: Text('Check Riwayat'),
              onTap: () {
                // Navigate to Pesanan page
              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                // Log out
              },
            ),
          ],
        ),
      ),
    );
  }
}
