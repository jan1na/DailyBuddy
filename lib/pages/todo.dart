import 'package:flutter/material.dart';
import 'hub.dart';
import '../user.dart';

class Todo extends StatelessWidget {
  Todo({Key key, this.screenChanged, this.entry}) : super(key: key);

  final ValueChanged<Widget> screenChanged;
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              entry.title,
              style: Theme.of(context).textTheme.display1,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    screenChanged(new Hub(screenChanged: screenChanged));
                  },
                  child: Text('Zurück', style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {
                    entry.done = true;
                    screenChanged(new Hub(screenChanged: screenChanged));
                  },
                  child: Text('Erledigt', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
