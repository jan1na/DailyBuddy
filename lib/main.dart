import 'package:flutter/material.dart';
import 'start.dart';

void main() => runApp(Advisor());

class Advisor extends StatefulWidget {
  @override
  AdvisorState createState() => AdvisorState();
}

class AdvisorState extends State<Advisor> {
  Widget screen;

  AdvisorState() {
    screen = new Start(title: 'Quarantäneberater', screenChanged: change);
  }

  void change(Widget screen) {
    setState(() {
      this.screen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quarantänebarater',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: screen,
    );
  }
}
