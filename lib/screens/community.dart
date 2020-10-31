import 'package:flutter/material.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

List linkListCommunity = [];

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
      child: ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: linkListCommunity.length,
          itemBuilder: (BuildContext context, int index) {
            return SimpleUrlPreview(
              url: linkListCommunity[index],
              textColor: Color.fromRGBO(239, 234, 225, 1.0),
              bgColor: Color.fromRGBO(120, 176, 160, 1.0),
              previewHeight: 150,
            );
          }),
    );
  }
}

Future _communityData() async {
  String command = 'community\n1\n';
  // var event = await sendData(command);
  //
  // var communityIsbn = jsonDecode(event);
  // String link = communityIsbn.toString();
  //
  // var linkList = link.split('\n');
  //
  // if (linkList.isNotEmpty) {
  //   linkListCommunity.clear();
  //   linkListCommunity = linkList;
  // } else {
  //   linkListCommunity.add('https://www.google.com');
  // }
}
