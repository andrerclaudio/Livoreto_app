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
  Map<String, dynamic> fieldStrings = {
    'stop': 'aaa',
    'reading': 'aaa',
    'remaining': 'aaa',
    'percentage': 'aaa',
    'today': 'aaa',
    'start': 'aaa',
    'prediction': 'aaa',
    'streak': 'aaa',
    'total': 'aaa'
  };

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
      body: Container(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Leitura atual ...',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SimpleUrlPreview(
                      url: url,
                      textColor: Colors.white,
                      bgColor: Colors.blueGrey,
                      previewHeight: 150,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(fieldStrings['stop']),
                Text(fieldStrings['reading']),
                Text(fieldStrings['remaining']),
                Text(fieldStrings['percentage']),
                Text(fieldStrings['today']),
                Text(fieldStrings['start']),
                Text(fieldStrings['prediction']),
                Text(fieldStrings['streak']),
                Text(fieldStrings['total']),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var event = await sendData();
          fieldStrings = jsonDecode(event);
          setState(() {
            String str = fieldStrings['details'];
            var arr = str.split('\n');
            String ret = arr[6].toString();
            if (ret != '') {
              url = ret;
            }
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.update),
      ),
    );
  }
}
