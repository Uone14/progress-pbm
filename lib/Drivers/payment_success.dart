import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Drivers/home.dart';

class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // handle back button press
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/image/bca.png', // Menggunakan gambar dari aset lokal
              height: 24,
            ),
            SizedBox(width: 8),
          ],
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pembayaran Sukses',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.lightBlue[100],
              child: ClipOval(
                child: Image.asset(
                  'assets/image/Vector.png', // Gambar sukses dari aset lokal
                  fit: BoxFit.cover,
                  width: 90, // Sesuaikan ukuran gambar jika diperlukan
                  height: 90,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kirim Uang Ke',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 5),
            Text(
              'SALONPAS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Rp10.000',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Beranda_Driver(username: 'user'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(63, 81, 181, 1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Tutup',
                style: TextStyle(fontSize: 16)
                ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
