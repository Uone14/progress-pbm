import 'package:flutter/material.dart';

class TopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text('Top up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose an amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildAmountCard('Rp 20.000', 'assets/image/coin.png'),
                _buildAmountCard('Rp 40.000', 'assets/image/coin.png'),
                _buildAmountCard('Rp 60.000', 'assets/image/coin.png'),
                _buildAmountCard('Rp 80.000', 'assets/image/coin.png'),
                _buildAmountCard('Rp 100.000', 'assets/image/coin.png'),
                _buildAmountCard('Rp 200.000', 'assets/image/coin.png'),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Or, type the amount'),
              onPressed: () {
                // Handle custom amount input
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle continue button press
              },
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(63, 81, 181, 1),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountCard(String amount, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          // Handle amount selection
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 50,
              width: 50,
            ),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
