import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:livoreto_app/services/socket.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

String url = "https://www.google.com";
Map<String, dynamic> fieldStrings = {
  'stop': '',
  'reading': '',
  'remaining': '',
  'percentage': '',
  'today': '',
  'start': '',
  'prediction': '',
  'streak': '',
  'title': '',
  'author': '',
  'publisher': '',
  'cover': '',
  'language': '',
  'isbn13': '',
  'link': '',
  'total': '',
  'book_qty': '',
  'book_list': '',
  'pages': '',
  'mean': '',
  'max': '',
  'week_max': '',
  'week_min': '',
  'clusters': '',
};

class OurHomeScreen extends StatefulWidget {
  @override
  _OurHomeScreenState createState() => _OurHomeScreenState();
}

class _OurHomeScreenState extends State<OurHomeScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    CommunityScreen(),
  ];

  Future _fetchUserData() async {
    String command = 'info\n1\n';
    var event = await sendData(command);

    fieldStrings = jsonDecode(event);

    String str = fieldStrings['link'];
    if (str != '') {
      url = str;
    }
    setState(() {});
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
                _fetchUserData();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _fetchUserData().then((value) {});
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
      body: _widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(120, 176, 160, 1.0),
        onPressed: () async {
          _addNewPageDialog();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromRGBO(120, 176, 160, 1.0),
        backgroundColor: Color.fromRGBO(239, 218, 185, 1.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Recomendação',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Comunidade',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(239, 218, 185, 1.0)),
      child: ListView(
        children: [
          Column(
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
                                  width: 4.0,
                                  color: Color.fromRGBO(80, 76, 79, 0.5)),
                              bottom: BorderSide(
                                  width: 4.0,
                                  color: Color.fromRGBO(80, 76, 79, 0.5)),
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
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8.0, 1.0, 4.0, 1.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Pág. lidas hoje: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['today'],
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
                                    'Iniciado em: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['start'],
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
                                    'Previsão\nde término: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['prediction'],
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
                              const EdgeInsets.fromLTRB(8.0, 1.0, 4.0, 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Nº de dias lendo em sequência: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['streak'],
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
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border(
                              top: BorderSide(
                                  width: 4.0,
                                  color: Color.fromRGBO(80, 76, 79, 0.5)),
                              bottom: BorderSide(
                                  width: 4.0,
                                  color: Color.fromRGBO(80, 76, 79, 0.5)),
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 1.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Livro: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['title'],
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
                              const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 1.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Autor: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['author'],
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
                              const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 1.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Editora: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['publisher'],
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
                              const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 1.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Isbn: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['isbn13'],
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
                              const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Qtd. de páginas: ',
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(80, 76, 79, 1.0),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    fieldStrings['total'],
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {

  @override
  void initState() {
    _communityData().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(239, 218, 185, 1.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Column(
              children: [
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future _communityData() async {
  String command = 'community\n1\n';
  var event = await sendData(command);

  var communityIsbn = jsonDecode(event);
  String asd = communityIsbn.toString();
  print(asd);
  //
  // String str = fieldStrings['link'];
  // if (str != '') {
  //   url = str;
  // }
}

