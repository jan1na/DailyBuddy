import 'package:flutter/material.dart';
import 'fromto.dart';

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
