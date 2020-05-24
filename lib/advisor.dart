import 'package:daily_buddy_app/pages/start.dart';
import 'package:flutter/material.dart';

class Advisor extends StatefulWidget {
  @override
  AdvisorState createState() => AdvisorState();
}

class AdvisorState extends State<Advisor> {
  Widget _screen;

  AdvisorState() {
    _screen = Start(screenChanged: change);
  }

  void change(Widget screen) {
    setState(() {
      this._screen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quarantäneberater',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _screen,
    );
  }
}
