import 'package:flutter/material.dart';
import 'hub.dart';

class Help extends StatefulWidget {
  Help({Key key, this.screenChanged}) : super(key: key);

  final ValueChanged<Widget> screenChanged;

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hilfe',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Ich fühle mich isoliert',
                  style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {},
              child:
                  Text('Ich benötige Medizin', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Ich brauche Essen', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                widget.screenChanged(
                    new Hub(screenChanged: widget.screenChanged));
              },
              child: Text('Zurück', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
