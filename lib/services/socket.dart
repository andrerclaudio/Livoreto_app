import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

Future<String> sendData() async {
  // Send data through Socket

  String textToShow = "";

  Socket socket = await Socket.connect('192.168.0.163', 5000);
  log('Connected');

  // listen to the received data event stream
  socket.listen((List<int> event) {
    textToShow = utf8.decode(event);
  });

  // send Status
  // socket.add(utf8.encode('page\n@1@600'));
  socket.add(utf8.encode('status\n@1@ '));

  await Future.delayed(Duration(seconds: 3));

  // .. and close the socket
  socket.destroy();
  log('Disconnected');

  return textToShow.toString();
}
