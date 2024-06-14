import 'package:flutter/material.dart';

class PelamarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pelamar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: ListView(
        children: [
          PelamarTile(
            imagePath: 'assets/image/profil.png',
            name: 'Toni',
            address: 'Johar Plaza, Jl. Diponegoro No.66, Tembaan, Kepatihan, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 18:07',
          ),
          PelamarTile(
            imagePath: 'assets/image/profil.png',
            name: 'Gita',
            address: 'Jl. Hayam Wuruk No.50-58, Gerdu, Sempusari, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 17:00',
          ),
          PelamarTile(
            imagePath: 'assets/image/profil.png',
            name: 'Salonpas',
            address: 'Jl. Sentot Prawirodirjo No.88, Telengsah, Jember Kidul, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 15:26',
          ),
          PelamarTile(
            imagePath: 'assets/image/profil.png',
            name: 'Kezia',
            address: 'Jl. Gajah Mada No.106, Kb. Kidul, Jember Kidul, Kec. Kaliwates, Kabupaten Jember',
            date: '13 Apr, 13:19',
          ),
        ],
      ),
    );
  }
}

class PelamarTile extends StatelessWidget {
  final String imagePath;
  final String name;
  final String address;
  final String date;

  PelamarTile({
    required this.imagePath,
    required this.name,
    required this.address,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(imagePath),
                  radius: 24.0,
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      date,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: Text(address),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Data',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Tolak',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
