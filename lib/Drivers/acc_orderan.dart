import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Drivers/message.dart';

class RideDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nebeng Bro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/driver_avatar.png'), // Replace with your image asset
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Daffa Arif....',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Status Kerja: Aktif',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow),
                    Text(
                      '5.00',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '#443',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            Text(
              'Tiba',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Bayar pakai NebengPay Rp15.000',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            RideLocation(
              title: 'Universitas Jember',
              address:
                  'Jl. Kalimantan Tegalboto No.37, Krajan Timur, Sumbersari, Kec. Sumbersari, Kabupaten Jember, Jawa Timur 68121',
              iconColor: Colors.blue,
            ),
            SizedBox(height: 20),
            RideLocation(
              title: 'Lippo Plaza Jember',
              address:
                  'Jl. Gajah Mada No.106, Kb. Kidul, Jember Kidul, Kec. Kaliwates, Kabupaten Jember, Jawa Timur 68131',
              iconColor: Colors.red,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TextMessageScreen()),
                    );
                  },
                  icon: Icon(Icons.chat),
                  label: Text('Chat'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.person_add),
                  label: Text('Jemput Pelanggan'),
                ),
              ],
            ),
            SizedBox(height: 20), // Add space between buttons and back button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Set full width and height
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TextMessageScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat with Daffa Arif....'),
//       ),
//       body: Center(
//         child: Text('This is the chat screen'),
//       ),
//     );
//   }
// }

class RideLocation extends StatelessWidget {
  final String title;
  final String address;
  final Color iconColor;

  RideLocation({
    required this.title,
    required this.address,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(Icons.location_on, color: iconColor),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                address,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
