import 'package:flutter/material.dart';
import 'package:livoreto_app/screens/community.dart';
import 'package:livoreto_app/screens/history.dart';
import 'package:livoreto_app/screens/home.dart';
import 'package:livoreto_app/screens/recommendation.dart';
import 'package:livoreto_app/services/mqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';

String mqttRxData;
final builder = MqttClientPayloadBuilder();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Livoreto',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OurHomeScreen(),
    );
  }
}

class OurHomeScreen extends StatefulWidget {
  @override
  _OurHomeScreenState createState() => _OurHomeScreenState();
}

class _OurHomeScreenState extends State<OurHomeScreen> {
  int _selectedIndex = 0;
  String topic = "topic/test";
  var client;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    RecommendationScreen(),
    CommunityScreen(),
  ];

  Future _mqttInit() async {
    client = await connect();
    client.subscribe(topic, MqttQos.atLeastOnce);
    _fetchUserData();
  }

  Future _fetchUserData() async {
    String command = 'info\n1\n';
    builder.addString(command);
    var event = await client.publishMessage(
        topic, MqttQos.atLeastOnce, builder.payload);
  }

  // fieldStrings = jsonDecode(event);
  //
  // String str = fieldStrings['link'];
  // if (str != '') {
  //   url = str;
  // }
  // setState(() {});

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
                // await sendData(command);
                // _fetchUserData();
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
    _mqttInit().then((value) {});
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
