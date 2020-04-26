import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
          title: Text('Dummy')
      ),
      body: Text('Hier ist noch nichts.'),
    );
  }
}