import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RIWAYAT'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRiwayatItem(
            date: '13 Apr, 18:07',
            name: 'Dynand Fariz',
            location: 'International High Fa..',
            price: 'Rp15.000',
            status: 'Perjalanan selesai',
            statusColor: Colors.green,
            statusIcon: Icons.check_circle,
            imagePath: 'assets/image/profilriwayat.png',
          ),
          _buildRiwayatItem(
            date: '20 Jan, 10:30',
            name: 'Roxy Square',
            location: 'Jember',
            price: 'Rp20.000',
            status: 'Perjalanan dibatalkan',
            statusColor: Colors.red,
            statusIcon: Icons.cancel,
            imagePath: 'assets/image/profilriwayat.png',
          ),
          _buildRiwayatItem(
            date: '25 Des, 12:00',
            name: 'Fakultas Ilmu Komputer UNEJ',
            location: '',
            price: 'Rp18.000',
            status: 'Perjalanan selesai',
            statusColor: Colors.green,
            statusIcon: Icons.check_circle,
            imagePath: 'assets/image/profilriwayat.png',
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatItem({
    required String date,
    required String name,
    required String location,
    required String price,
    required String status,
    required Color statusColor,
    required IconData statusIcon,
    required String imagePath,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Icon(statusIcon, color: statusColor, size: 16),
                    SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(color: statusColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            price,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
