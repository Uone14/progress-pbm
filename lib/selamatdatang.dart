import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Admins/login.dart';
import 'package:nebengbro_apps/Drivers/landing.dart';
import 'package:nebengbro_apps/welcome2.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 5),
            Image.asset(
              'assets/image/Logo.png', // Replace with your logo asset
              height: 100,
            ),
            Text(
              'Nebeng Bro', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Spacer(flex: 1),
            CustomButton(
              text: 'Admin', 
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage_Admin(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Driver',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LandingPage(),
                  ),
                );
              }
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Customer',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen2(),
                  ),
                );
              },
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // Set the width of the button
      height: 50, // Adjust the height of the button to fit the text
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF286090), // Button color
          foregroundColor: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
