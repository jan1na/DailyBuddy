import 'package:DailyBuddy/pages/dayplan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pages/start.dart';

void main() => runApp(Advisor());

class Advisor extends StatefulWidget {
  @override
  AdvisorState createState() => AdvisorState();
}

class AdvisorState extends State<Advisor> {
  Widget screen;

  AdvisorState() {
    Intl.defaultLocale = 'de_DE';
    //screen = new Start(screenChanged: change);
    screen = DayPlanScreen();
  }

  void change(Widget screen) {
    setState(() {
      this.screen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quarantäneberater',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: screen,
    );
  }
}
