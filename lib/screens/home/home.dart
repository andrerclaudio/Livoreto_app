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
    'stop': '-',
    'reading': '-',
    'remaining': '-',
    'percentage': '-',
    'today': '-',
    'start': '-',
    'prediction': '-',
    'streak': '-',
    'total': '-'
  };

  Future _onLoading() async {
    String command = 'status\n1\n';
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
  }

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
  void initState() {
    _onLoading().then((value) {});
    super.initState();
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
                child: Column(
                  children: [
                    SimpleUrlPreview(
                      url: url,
                      textColor: Color.fromRGBO(239, 234, 225, 1.0),
                      bgColor: Color.fromRGBO(120, 176, 160, 1.0),
                      previewHeight: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 16.0),
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
                    Container(
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.all(Radius.circular(16)),
                          border: Border(
                        top: BorderSide(
                            width: 4.0, color: Color.fromRGBO(80, 76, 79, 0.5)),
                        bottom: BorderSide(
                            width: 4.0, color: Color.fromRGBO(80, 76, 79, 0.5)),
                      )),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 1.0),
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
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 1.0, 4.0, 1.0),
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
