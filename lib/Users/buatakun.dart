import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nebengbro_apps/Users/loginpage.dart';

class BuatAkun extends StatefulWidget {
  @override
  _BuatAkunState createState() => _BuatAkunState();
}

class _BuatAkunState extends State<BuatAkun> {
  bool _rememberMe = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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

  Future<void> _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Simpan data pengguna di Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
      });

      // Beralih ke halaman login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      // Tangani error FirebaseAuthException
      String message;
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Akun dengan email ini sudah ada.';
      } else {
        message = 'Terjadi kesalahan. Silakan coba lagi.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      // Tangani error umum
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terjadi kesalahan. Silakan coba lagi.')));
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
              const SizedBox(height: 20.0), // Beri jarak antara logo dan batas atas layar
              logoImage,
              const SizedBox(height: 16.0), // Beri jarak antara logo dan teks "Buat Akun"
              const Center(
                child: Text(
                  'Buat Akun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32.0), // Beri jarak antara teks "Buat Akun" dan input fields
              TextField(
                controller: _nameController,
                maxLines: 1,
                keyboardType: TextInputType.name, // Menentukan jenis keyboard untuk nama
                decoration: InputDecoration(
                  hintText: 'Masukkan Nama',
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
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
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword, // Menentukan jenis keyboard untuk kata sandi
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Kata Sandi',
                  labelText: 'Kata Sandi',
                  suffixIcon: const Icon(Icons.visibility_off),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
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
                  const Text('Ingat saya'),
                ],
              ),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Buat Akun'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Lupa sandi?'),
              ),
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
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
              const SizedBox(height: 10), // Beri jarak antara logo Google dan teks "Tidak memiliki akun?"
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text('Sudah punya akun? Masuk'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
