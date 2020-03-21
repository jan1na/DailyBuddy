import 'package:flutter/material.dart';

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

class Start extends StatelessWidget {
  Start({Key key, this.title, this.screenChanged})
      : super(key: key);

  final String title;
  final ValueChanged<Widget> screenChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Willkommen bei der Quarantänebarater App',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              'Ein paar Fragen, dann sind wir bereit.'
            ),
            RaisedButton(
              onPressed: () {
                screenChanged(new FromTo(title: 'Von Bis', screenChanged: screenChanged));
              },
              child: Text(
                'Weiter',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FromTo extends StatelessWidget {
  FromTo({Key key, this.title, this.screenChanged})
      : super(key: key);

  final String title;
  final ValueChanged<Widget> screenChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Von wann bis wann',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
    );
  }
}
