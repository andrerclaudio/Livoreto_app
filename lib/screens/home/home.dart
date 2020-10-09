import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:livoreto_app/services/socket.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

class OurHomeScreen extends StatefulWidget {
  @override
  _OurHomeScreenState createState() => _OurHomeScreenState();
}

class _OurHomeScreenState extends State<OurHomeScreen> {
  String url = "https://www.goodreads.com";

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
      body: SimpleUrlPreview(
        url: url,
        textColor: Colors.white,
        bgColor: Colors.blueGrey,
        previewHeight: 150,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var event = await sendData();
          Map<String, dynamic> user = jsonDecode(event);
          setState(() {
            String str = user['details'];
            var arr = str.split('\n');
            url = arr[6].toString();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.update),
      ),
    );
  }
}
