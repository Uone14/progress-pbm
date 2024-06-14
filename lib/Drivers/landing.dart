import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Drivers/login.dart';
import 'package:nebengbro_apps/Drivers/nomor.dart';
import 'package:nebengbro_apps/Drivers/pendaftarandriver.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
                        'assets/image/Logo.png',
                        height: 80.0,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Nebeng Bro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
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
                  height: 400.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Halo, Mitra Driver! Udah siap jalan?',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 21, 21),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Yuk, masuk untuk mulai terima orderan!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 1, 1, 1),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login_Driver()),
                          );
                        },
                        child: Text('Masuk'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                              color: Color.fromRGBO(101, 147, 172, 100),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          minimumSize: Size(500, 40),
                          backgroundColor: Color.fromRGBO(101, 147, 172, 100),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegistrasiDriver()),
                          );
                        },
                        child: Text('Daftar'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                              color: Color.fromRGBO(101, 147, 172, 100),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          minimumSize: Size(500, 40),
                          backgroundColor: Color.fromRGBO(101, 147, 172, 100),
                          foregroundColor: Colors.white,
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
