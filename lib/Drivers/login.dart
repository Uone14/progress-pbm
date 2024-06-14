import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nebengbro_apps/Drivers/home.dart'; // Optional: for showing toast messages

class Login_Driver extends StatefulWidget {
  const Login_Driver({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login_Driver> {
  bool passwordHide = true; // Initially hide password

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordHide = !passwordHide;
    });
  }

  void signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Navigate to home or dashboard after successful login
      // Replace Beranda_Driver with your actual home screen widget
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Beranda_Driver(username: userCredential.user!.displayName ?? 'user')),
      );
    } catch (e) {
      print('Error signing in: $e');
      // Optional: Show error message using Fluttertoast or showDialog
      Fluttertoast.showToast(
        msg: "Login failed. Check your email and password.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 254, 254),
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                children: <Widget>[
                  buildTextField(context, 'Email', 'Email', emailController),
                  buildPasswordField(context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: signInWithEmailAndPassword,
                    child: Text(
                      'Kirim',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext context, String label, String hint, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: hint,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }

  Widget buildPasswordField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.065,
                    child: TextField(
                      controller: passwordController,
                      obscureText: passwordHide,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 0.5),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(passwordHide ? Icons.visibility : Icons.visibility_off),
                          onPressed: togglePasswordVisibility,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
        ],
      ),
    );
  }
}
