import 'package:flutter/material.dart';
import 'dates.dart';

class Start extends StatelessWidget {
  Start({Key key, this.screenChanged}) : super(key: key);

  final ValueChanged<Widget> screenChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Willkommen bei der Quarantänebarater App',
              style: Theme.of(context).textTheme.display1,
            ),
            Text('Ein paar Fragen, dann sind wir bereit.'),
            Image.asset('assets/Logo_Projekt_02.png'),
            RaisedButton(
              onPressed: () {
                screenChanged(new Dates(screenChanged: screenChanged));
              },
              child: Text('Weiter', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
