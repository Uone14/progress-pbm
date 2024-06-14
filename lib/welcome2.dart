import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Users/buatakun.dart';
import 'package:nebengbro_apps/Users/loginpage.dart';

class WelcomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Gambar latar belakang
          Positioned.fill(
            child: Image.asset(
              'assets/image/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/Logo.png', // Pastikan Anda memiliki aset ini
                        height: 80.0,
                      ),
                      SizedBox(width: 10), // Spacer antara logo dan teks
                      Text(
                        'Nebeng Bro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set warna teks menjadi putih
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(), // Ini akan mengisi ruang kosong dan mendorong container ke bawah
                Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  width: double.infinity,
                  height: 400.0, // Atur tinggi container sesuai kebutuhan
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Selamat Datang di Nebeng Bro\nNebeng Bro, aplikasi yang membantu Anda untuk terhubung lebih efektif dalam perjalanan Anda. Dengan Nebeng Bro anda dapat merencanakan perjalanan bersama untuk mencapai tujuan dengan lebih efisien.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text('Masuk'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Color.fromRGBO(
                                    101, 147, 172, 100)), // Warna border
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          minimumSize: Size(400, 30), // Ukuran minimum tombol
                          backgroundColor: Color.fromRGBO(101, 147, 172,
                              100), // Warna latar belakang tombol
                          foregroundColor: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BuatAkun(),
                            ),
                          );
                        },
                        child: Text('Belum punya akun? Daftar yuk!'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white, // Warna teks tombol
                          side: BorderSide(
                              color: Color.fromRGBO(
                                  41, 84, 41, 100)), // Warna border
                          minimumSize: Size(400, 30),
                          foregroundColor: Color.fromRGBO(
                              41, 84, 41, 100), // Ukuran minimum tombol
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen2(),
  ));
}
