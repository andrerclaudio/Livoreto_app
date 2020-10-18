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
                            // bottom: BorderSide(
                            //     width: 4.0,
                            //     color: Color.fromRGBO(80, 76, 79, 0.5)),
                          ),
                        ),
                        child: Column(
                          children: [
                            HomeScreenBodyInfoReading(
                              title: 'Pág. restantes: ',
                              info: fieldStrings['remaining'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Percentual lido: ',
                              info: fieldStrings['percentage'] + '%',
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Pág. lidas hoje: ',
                              info: fieldStrings['today'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Iniciado em: ',
                              info: fieldStrings['start'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Previsão de término: ',
                              info: fieldStrings['prediction'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Nº de dias lendo em sequência: ',
                              info: fieldStrings['streak'],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.all(Radius.circular(16)),
                          border: Border(
                            // top: BorderSide(
                            //     width: 4.0,
                            //     color: Color.fromRGBO(80, 76, 79, 0.5)),
                            bottom: BorderSide(
                                width: 4.0,
                                color: Color.fromRGBO(80, 76, 79, 0.5)),
                          ),
                        ),
                        child: Column(
                          children: [
                            // HomeScreenBodyInfoReading(
                            //   title: 'Livro: ',
                            //   info: fieldStrings['title'],
                            // ),
                            HomeScreenBodyInfoReading(
                              title: 'Autor(a): ',
                              info: fieldStrings['author'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Editora: ',
                              info: fieldStrings['publisher'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Isbn: ',
                              info: fieldStrings['isbn13'],
                            ),
                            HomeScreenBodyInfoReading(
                              title: 'Qtd. de páginas: ',
                              info: fieldStrings['total'],
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

class HomeScreenBodyInfoReading extends StatelessWidget {
  HomeScreenBodyInfoReading({Key key, this.title, this.info}) : super(key: key);

  final String title;
  final String info;

  static const TextStyle optionStyleInfoTitle = TextStyle(
      fontSize: 14,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(80, 76, 79, 1.0));
  static const TextStyle optionStyleInfoBody = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(80, 76, 79, 1.0));

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, .0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(
            title,
            style: optionStyleInfoTitle,
            softWrap: true,
          ),
          new Flexible(
            child: new Text(
              info,
              style: optionStyleInfoBody,
              softWrap: true,
            ),
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
              children: [],
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
