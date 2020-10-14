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

  void _addNewPageDialog() {
    TextEditingController _addNewPageValue = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Digite o número da pág. que parou!",
            style: TextStyle(color: Color.fromRGBO(80, 76, 79, 1.0)),
          ),
          content: TextFormField(
            controller: _addNewPageValue,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.menu_book_outlined),
              labelText: 'Página *',
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                'Salvar',
                style: TextStyle(
                    fontSize: 24, color: Color.fromRGBO(80, 76, 79, 1.0)),
              ),
              onPressed: () async {
                Navigator.of(context).pop();

                var value = _addNewPageValue.text;
                String command = 'page\n1\n$value';
                await sendData(command);

                command = 'status\n1\n';
                var event = await sendData(command);

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
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(80, 76, 79, 1.0),
        title: Text(
          'Livoreto',
          style: TextStyle(color: Color.fromRGBO(239, 234, 225, 1.0)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(239, 218, 185, 1.0)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // decoration: BoxDecoration(
                //     color: Color.fromRGBO(120, 176, 160, 1.0),
                //     borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Column(
                  children: [
                    SimpleUrlPreview(
                      url: url,
                      textColor: Color.fromRGBO(239, 234, 225, 1.0),
                      bgColor: Color.fromRGBO(120, 176, 160, 1.0),
                      previewHeight: 150,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Última pág. lida: ',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(80, 76, 79, 1.0),
                                  fontSize: 16),
                            ),
                            Text(
                              fieldStrings['stop'],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(80, 76, 79, 1.0),
                                  fontSize: 48),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text(
                            'Pág. restantes: ',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(80, 76, 79, 1.0),
                                fontSize: 16),
                          ),
                          Text(
                            fieldStrings['remaining'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(80, 76, 79, 1.0),
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text(
                            'Percentual lido: ',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(80, 76, 79, 1.0),
                                fontSize: 16),
                          ),
                          Text(
                            fieldStrings['percentage'] + '%',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(80, 76, 79, 1.0),
                                fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(120, 176, 160, 1.0),
        onPressed: () async {
          _addNewPageDialog();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
