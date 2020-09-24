import 'dart:async';
import 'dart:convert';
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
  @override
  _FetchStatusState createState() => _FetchStatusState();
}

class _FetchStatusState extends State<FetchStatus> {
  String textToShow = "";

  sendData() async {
    Socket socket = await Socket.connect('192.168.0.163', 5000);
    print('connected');

    // listen to the received data event stream
    socket.listen((List<int> event) {
      print(utf8.decode(event));
      textToShow = utf8.decode(event);
    });

    // send hello
    socket.add(utf8.encode('hello'));

    // wait 5 seconds
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      // .. and close the socket
      socket.destroy();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          height: 100,
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
              onPressed: () {
                sendData();
              },
              child: Text(
                "Press to get status!",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(8.0),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
              child: Text(
            textToShow,
          )),
        )
      ],
    );
  }
}
