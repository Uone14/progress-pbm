import 'package:flutter/material.dart';

class PelamarPage_Driver extends StatelessWidget {
  final List<Map<String, dynamic>> riwayat = [
    {
      "name": "Johar Pkaza",
      "address": "Jl. Diponegoro No.66, Tembaan, Kepatihan, Kec. Kaliwates, Kabupaten Jember",
      "date": "13 Apr, 18:07",
      "status": "Diterima",
      "avatar": Icons.person,
      "avatarImage": 'assets/avatar1.png',
      "statusColor": Colors.green,
    },
    {
      "name": "Jil. Hayam Wuruk",
      "address": "Jl. Hayam Wuruk No.50-58, Gerdu, Sempusari, Kec. Kaliwates, Kabupaten Jember",
      "date": "13 Apr, 17:00",
      "status": "Diterima",
      "avatar": Icons.person_outline,
      "avatarImage": 'assets/avatar2.png',
      "statusColor": Colors.green,
    },
    {
      "name": "Jil. Sentot Prawirodirjo",
      "address": "No.88, Tegalnesah, Jember Kidul, Kec. Kaliwates, Kabupaten Jember",
      "date": "13 Apr, 15:26",
      "status": "Diterima",
      "avatar": Icons.person,
      "avatarImage": 'assets/avatar3.png',
      "statusColor": Colors.green,
    },
    {
      "name": "Jil. Gajah Mada",
      "address": "No.106, Kb. Kidul, Jember Kidul, Kec. Kaliwates, Kabupaten Jember",
      "date": "13 Apr, 13:19",
      "status": "Ditolak",
      "avatar": Icons.person_outline,
      "avatarImage": 'assets/avatar4.png',
      "statusColor": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Action for back button
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/logo1.png', height: 100),
                Image.asset('assets/logo2.png', height: 100),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: riwayat.length,
              itemBuilder: (context, index) {
                final item = riwayat[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(item['avatarImage']),
                  ),
                  title: Text(item['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['address']),
                      Text(item['date']),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.grey,
                        ),
                        child: Text('Data'),
                      ),
                      SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.green,
                        ),
                        child: Text('Confirm'),
                      ),
                      SizedBox(height: 4),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                         backgroundColor: Colors.red,
                        ),
                        child: Text('Tolak'),
                      ),
                    ],
                  ),
                  contentPadding: EdgeInsets.all(8),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
