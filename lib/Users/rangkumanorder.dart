import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Rangkumanorder extends StatefulWidget {
  const Rangkumanorder({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RangkumanorderState createState() => _RangkumanorderState();
}

class _RangkumanorderState extends State<Rangkumanorder> {
  String pickupLocation = 'Loading...';
  String dropLocation = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchPickupLocation();
    _fetchDropLocation();
  }

  Future<void> _fetchPickupLocation() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('locations/start/name');
    DatabaseEvent event = await ref.once();
    setState(() {
      pickupLocation = event.snapshot.value.toString();
    });
  }
  Future<void> _fetchDropLocation() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('locations/end/name');
    DatabaseEvent event = await ref.once();
    setState(() {
      dropLocation = event.snapshot.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildOrderDetails(),
            const SizedBox(height: 16),
            _buildTravelDetails(),
            const SizedBox(height: 16),
            _buildPaymentDetails(),
            const Spacer(),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.directions_car, size: 40, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              'Nebeng Bro',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text('13 Apr, 18:07', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 30,
          child: const Icon(Icons.person, size: 40, color: Colors.blue),
        ),
        const SizedBox(width: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daffa Arif Muhammad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Daihatsu Ayla'),
            Text('P5034YZ'),
          ],
        ),
      ],
    );
  }

  Widget _buildTravelDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detail Perjalanan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Row(
          children: [
            Icon(Icons.arrow_upward, color: Colors.blue),
            SizedBox(width: 8),
            Text('Lokasi jemput',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                pickupLocation,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ),
          ],
        ),
        const Row(
          children: [
            Icon(Icons.more_vert, color: Colors.grey),
            SizedBox(width: 8),
            Text('4 km', style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
        const Row(
          children: [
            Icon(Icons.arrow_downward, color: Colors.red),
            SizedBox(width: 8),
            Text('Lokasi tujuan',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                dropLocation,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rincian Pembayaran',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildPaymentRow('Biaya Perjalanan', 'Rp10.000'),
        _buildPaymentRow('Biaya jasa aplikasi', 'Rp5.000'),
        const Divider(),
        _buildPaymentRow('Total', 'Rp15.000'),
        const Divider(),
        _buildPaymentRow('Bayar Pakai NebengPay', 'Rp15.000'),
      ],
    );
  }

  Widget _buildPaymentRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Text(amount, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: const Text(
          'Back',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
