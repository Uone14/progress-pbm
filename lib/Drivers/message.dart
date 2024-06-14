import 'package:flutter/material.dart';

class TextMessageScreen extends StatefulWidget {
  @override
  _TextMessageScreenState createState() => _TextMessageScreenState();
}

class _TextMessageScreenState extends State<TextMessageScreen> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Apakah masih lama ya pak?',
      'timestamp': '19:02',
      'isSender': false,
    },
  ];

  void _addMessage(String text) {
    final timestamp = DateTime.now().toString().substring(10, 16);
    setState(() {
      _messages.add({
        'text': text,
        'timestamp': timestamp,
        'isSender': true,
      });
    });
    _controller.clear();
  }

  void _addSticker() {
    final timestamp = DateTime.now().toString().substring(10, 16);
    setState(() {
      _messages.add({
        'text': '🙂',
        'timestamp': timestamp,
        'isSender': true,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile_image.png'), // Replace with your actual profile image path
              radius: 20.0,
            ),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dayin',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Perumahan Rich Village RD. 35',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // Action for call button
            },
            color: Colors.blue, // Background color for the button
            padding: EdgeInsets.all(12.0),
            constraints: BoxConstraints(),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0), // Space between AppBar and messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () {
                    // Add your photo uploading logic here.
                  },
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions),
                  onPressed: _addSticker,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    if (message['isSender']) {
      return _buildSenderMessage(
        text: message['text'],
        timestamp: message['timestamp'],
      );
    } else {
      return _buildReceiverMessage(
        text: message['text'],
        timestamp: message['timestamp'],
      );
    }
  }

  Widget _buildSenderMessage({required String text, required String timestamp}) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
            constraints: BoxConstraints(
              minWidth: 120.0,
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            margin: EdgeInsets.only(bottom: 16.0, left: 16.0, right: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  timestamp,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 16.0,
          child: ClipPath(
            clipper: BubbleClipper(),
            child: Container(
              height: 16.0,
              width: 40.0,
              color: Colors.blue[100],
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 16.0,
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {
                // Add your photo uploading logic here.
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiverMessage({required String text, required String timestamp}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
          ),
          constraints: BoxConstraints(
            minWidth: 120.0,
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          margin: EdgeInsets.only(bottom: 16.0, left: 50.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 4.0),
              Text(
                timestamp,
                style: TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
        ),
        ClipPath(
          clipper: BubbleClipper(isSender: false),
          child: Container(
            height: 16.0,
            width: 40.0,
            color: Colors.grey[100],
            margin: EdgeInsets.only(right: 10.0),
          ),
        ),
      ],
    );
  }
}

class BubbleClipper extends CustomClipper<Path> {
  final bool isSender;

  BubbleClipper({this.isSender = true});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (isSender) {
      path.moveTo(0, size.height);
      path.lineTo(size.width * 0.5, size.height);
      path.lineTo(size.width * 0.3, 0);
      path.close();
    } else {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width * 0.5, size.height);
      path.lineTo(size.width * 0.7, 0);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

void main() {
  runApp(MaterialApp(
    home: TextMessageScreen(),
  ));
}
