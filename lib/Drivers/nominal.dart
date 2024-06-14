import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nebengbro_apps/Drivers/tarik_pendapatan.dart'; // Import the intl package

class NominalPage extends StatefulWidget {
  @override
  _NominalPageState createState() => _NominalPageState();
}

class _NominalPageState extends State<NominalPage> {
  final TextEditingController _rekeningController = TextEditingController();
  String _formattedRekening = '';

  @override
  void dispose() {
    _rekeningController.dispose();
    super.dispose();
  }

  void _formatRekening(String value) {
    if (value.isEmpty) {
      setState(() {
        _formattedRekening = '';
      });
      return;
    }

    final numberFormat = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    final nominal = int.parse(value.replaceAll(RegExp(r'[^0-9]'), ''));
    setState(() {
      _formattedRekening = numberFormat.format(nominal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/image/bca.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              'SALONPAS',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 188, 186, 186), // Warna abu muda
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ISI NOMINAL',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 188, 186, 186), // Warna abu muda
              ),
            ),
            SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _rekeningController,
                    onChanged: _formatRekening,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Nominal',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Nominal Rupiah:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 188, 186, 186), // Warna abu muda
              ),
            ),
            SizedBox(height: 2),
            Text(
              _formattedRekening,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
              MaterialPageRoute(
                builder: (context) => BankTransferScreen(),
              ),
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
