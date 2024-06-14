import 'package:flutter/material.dart';

class RiwayatPage_Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
              Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          StatusTile(
            imagePath: 'assets/image/profil.png',
            name: 'Toni',
            address: 'Johar Plaza, Jl. Diponegoro No.66, Tembaan, Kepatihan, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 18:07',
            status: 'Diterima',
            statusColor: Colors.green,
          ),
          StatusTile(
            imagePath: 'assets/image/profil.png',
            name: 'Gita',
            address: 'Jl. Hayam Wuruk No.50-58, Gerdu, Sempusari, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 17:00',
            status: 'Ditolak',
            statusColor: Colors.red,
          ),
          StatusTile(
            imagePath: 'assets/image/profil.png',
            name: 'Rani',
            address: 'Jl. Sentot Prawirodirjo No.88, Telengsah, Jember Kidul, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 15:26',
            status: 'Diterima',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }
}

class StatusTile extends StatelessWidget {
  final String imagePath;
  final String name;
  final String address;
  final String date;
  final String status;
  final Color statusColor;

  StatusTile({
    required this.imagePath,
    required this.name,
    required this.address,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date),
          Text(address),
        ],
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}