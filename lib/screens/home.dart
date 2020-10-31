import 'package:flutter/material.dart';
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