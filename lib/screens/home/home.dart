import 'package:flutter/material.dart';

class OurHomeScreen extends StatelessWidget {
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
      body: Row(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a new Book',
        child: Icon(Icons.add),
      ),
    );
  }
}
