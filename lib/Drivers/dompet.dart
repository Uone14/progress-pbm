// import 'package:flutter/material.dart';
// import 'package:nebengbro_apps/driver/dompet1.dart';

// class PendapatanScreen extends StatefulWidget {
//   @override
//   _PendapatanScreenState createState() => _PendapatanScreenState();
// }

// class _PendapatanScreenState extends State<PendapatanScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Pendapatan',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Ringkasan pendapatan',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               DefaultTabController(
//                 length: 2,
//                 child: Column(
//                   children: [
//                     TabBar(
//                       labelColor: Colors.black,
//                       unselectedLabelColor: Colors.grey,
//                       indicatorColor: Colors.black,
//                       tabs: [
//                         Tab(text: 'Harian'),
//                         Tab(text: 'Mingguan'),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 400, // Adjusted to fit content better
//                       child: TabBarView(
//                         children: [
//                           _buildHarianTab(),
//                           Center(child: Text('Mingguan')),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHarianTab() {
//     return ListView(
//       padding: EdgeInsets.all(0),
//       children: [
//         SizedBox(height: 16),
//         Text(
//           'Hari ini',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Rp150.000',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 8),
//         Row(
//           children: [
//             Icon(Icons.list, color: Colors.grey),
//             SizedBox(width: 8),
//             Text(
//               '5 orderan selesai',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.blue),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Saldo',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 'Rp350.000',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 40),
//         Center(
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PendapatanScreen1()),
//               );
//             },
//             child: Text('Tarik Pendapatan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromRGBO(63, 81, 181, 1),
//               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }