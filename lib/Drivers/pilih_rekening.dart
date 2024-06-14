import 'package:flutter/material.dart';
import 'package:nebengbro_apps/Drivers/nomor_rekening.dart';

class PilihRekeningBankPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Rekening Bank'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
      ),
      body: ListView(
        children: [
          BankTile(
            imagePath: 'assets/image/bca.png',
            bankName: 'BCA',
            description: 'Top up with BCA',
          ),
          BankTile(
            imagePath: 'assets/image/mandiri.png',
            bankName: 'Mandiri',
            description: 'Top up with Mandiri',
          ),
          BankTile(
            imagePath: 'assets/image/bri.png',
            bankName: 'BRI',
            description: 'Top up with BRI',
          ),
          BankTile(
            imagePath: 'assets/image/bni.png',
            bankName: 'BNI',
            description: 'Top up with BNI',
          ),
          BankTile(
            imagePath: 'assets/image/bsi.png',
            bankName: 'BSI',
            description: 'Top up with BSI',
          ),
        ],
      ),
    );
  }
}

class BankTile extends StatelessWidget {
  final String imagePath;
  final String bankName;
  final String description;

  BankTile({
    required this.imagePath,
    required this.bankName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NomorRekeningPage(),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: ListTile(
          leading: Image.asset(
            imagePath,
            width: 50.0,
            height: 50.0,
          ),
          title: Text(bankName, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
