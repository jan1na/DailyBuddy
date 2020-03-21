import 'package:flutter/material.dart';
import 'names.dart';

class FromTo extends StatelessWidget {
  FromTo({Key key, this.title, this.screenChanged})
      : super(key: key);

  final String title;
  final ValueChanged<Widget> screenChanged;

  DateTime from;
  DateTime to;

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
                    from = picked;
                  }
              },
              child: Text(
                'Beginn',
                style: TextStyle(fontSize: 20)
              ),
            ),
            RaisedButton(
              onPressed: () async {
                final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101));
                  if (picked != null) {
                    to = picked;
                  }
              },
              child: Text(
                'Ende',
                style: TextStyle(fontSize: 20)
              ),
            ),
            RaisedButton(
              onPressed: () {
                screenChanged(new Names(title: 'Namen', screenChanged: screenChanged));
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
