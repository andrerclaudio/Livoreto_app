import 'dart:io';

import 'package:flutter/material.dart';

class OurHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Livoreto',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FetchStatus(),
    );
  }
}

class FetchStatus extends StatefulWidget {
  void sendData() {
    Socket.connect('192.168.0.163', 5000).then((socket) {
      print('Connected to: '
          '${socket.remoteAddress.address}:${socket.remotePort}');
      socket.write('I am a message from a Mobile Application');
      socket.destroy();
    });
  }

  @override
  _FetchStatusState createState() => _FetchStatusState();
}

class _FetchStatusState extends State<FetchStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      height: 128,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Center(
        child: FlatButton(
          color: Colors.blue,
          textColor: Colors.black,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: widget.sendData,
          child: Text(
            "Press to get status!",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
