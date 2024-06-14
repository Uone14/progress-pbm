import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nebengbro_apps/Users/buatakun.dart';
import 'package:nebengbro_apps/Users/homepage.dart';

class LoginPage_Admin extends StatefulWidget {
  @override
  _LoginPage_AdminState createState() => _LoginPage_AdminState();
}

class _LoginPage_AdminState extends State<LoginPage_Admin> {
  bool _rememberMe = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Inisialisasi gambar asset di luar metode build
  final logoImage = Image.asset(
    'assets/image/Logo.png', // Sesuaikan dengan lokasi file gambar PNG Anda
    width: 100.0,
    height: 100.0,
  );

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Beralih ke halaman beranda setelah berhasil login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage_User()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Tidak ada pengguna dengan email ini.';
      } else if (e.code == 'wrong-password') {
        message = 'Kata sandi salah.';
      } else {
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 32.0), // Beri jarak antara logo dan batas atas layar
              logoImage,
              SizedBox(height: 16.0), // Beri jarak antara logo dan teks "Masuk"
              Center(
                child: Text(
                  'Masuk',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 32.0), // Beri jarak antara teks "Masuk" dan input fields
              TextField(
                controller: _emailController,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress, // Menentukan jenis keyboard untuk email
                decoration: InputDecoration(
                  hintText: 'Masukkan Alamat Email',
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword, // Menentukan jenis keyboard untuk kata sandi
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Kata Sandi',
                  labelText: 'Kata Sandi',
                  suffixIcon: Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                  Text('Ingat saya'),
                ],
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Masuk'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Lupa sandi?'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Atau',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  // Aksi yang dijalankan saat logo Google diklik
                  // Tambahkan fungsi untuk masuk ke akun Google di sini
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/image/lg-google.png', // Ubah lokasi sesuai dengan logo Google Anda
                    width: 80, // Sesuaikan ukuran sesuai kebutuhan
                    height: 80,
                  ),
                ),
              ),
              SizedBox(height: 10), // Beri jarak antara logo Google dan teks "Tidak memiliki akun?"
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuatAkun()),
                  );
                },
                child: Text('Tidak memiliki akun? Buat Akun'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
