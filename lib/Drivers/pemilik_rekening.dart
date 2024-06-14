import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Drivers/nominal.dart';

class PemilikRekeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/image/bca.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text('BCA'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tambah rekening baru',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Nomor Rekening',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '0123 4859 39',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle verify button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 19, 247, 27),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(50, 25),
                  ),
                  child: Text('Verifikasi', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'NAMA PEMILIK REKENING',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 188, 186, 186), // Warna abu muda
              ),
            ),
            SizedBox(height: 8),
            Container(
              color: Colors.grey[300], // Background color for the row
              padding: EdgeInsets.all(8.0), // Optional padding inside the container
              child: Row(
                children: [
                  Image.asset(
                    'assets/image/bca.png', // Replace with the path to your image
                    height: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'SALONPAS', // Replace with the actual name
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NominalPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          child: Text('Lanjut', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
