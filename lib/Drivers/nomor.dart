import 'package:flutter/material.dart';
// import 'package:flutter_application_1/home.dart';
import 'package:nebengbro_apps/Drivers/home.dart';

class InputNomorHP extends StatefulWidget {
  const InputNomorHP({super.key});

  @override
  State<InputNomorHP> createState() => _InputNomorHPState();
}

class _InputNomorHPState extends State<InputNomorHP> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masukkan Nomor HP'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Gunakan nomor yang terdaftar di kami.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nomor Hp',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Beranda_Driver(username: 'user')));
              },
              child: Text('LANJUT'),
            ),
          ],
        ),
      ),
    );
  }
}
