import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ChatItem(
            name: 'Dayin',
            message: 'Apakah masih lama ya pak?',
            time: '18:35 pm',
            unread: false,
          ),
          ChatItem(
            name: 'Yuan',
            message: 'Haloo, apakah sudah sesuai.....',
            time: '19:05 pm',
            unread: true,
          ),
          ChatItem(
            name: 'Palupi',
            message: 'Menuju titik lokasi',
            time: '18:20 pm',
            unread: false,
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool unread;

  ChatItem(
      {required this.name,
      required this.message,
      required this.time,
      required this.unread});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(
            'assets/image/prochat1.png'), // Add an avatar image to your assets
        radius: 24,
      ),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: TextStyle(color: Colors.grey)),
          if (unread)
            Container(
              margin: EdgeInsets.only(top: 5.0),
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '1',
                style: TextStyle(color: Colors.white, fontSize: 12.0),
              ),
            ),
        ],
      ),
    );
  }
}
