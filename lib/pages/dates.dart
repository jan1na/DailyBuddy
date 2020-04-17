import 'package:flutter/material.dart';
import 'hub.dart';
import '../user.dart';

class Dates extends StatelessWidget {
  Dates({Key key, this.screenChanged}) : super(key: key);

  final ValueChanged<Widget> screenChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Von wann bis wann soll die Quarantäne gehen?',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: () async {
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101));
                if (picked != null) {
                  User.the().from = picked;
                }
              },
              child: Text('Beginn', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () async {
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now().add(Duration(days: 14)),
                    firstDate: DateTime(2015, 8),
                    lastDate: DateTime(2101));
                if (picked != null) {
                  User.the().to = picked;
                }
              },
              child: Text('Ende', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                screenChanged(new Hub(screenChanged: screenChanged));
              },
              child: Text('Weiter', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
