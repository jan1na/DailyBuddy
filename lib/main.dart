import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Advisor(title: 'Quarantänebarater'),
    );
  }
}

class Advisor extends StatefulWidget {
  Advisor({Key key, this.title}) : super(key: key);

  final String title;

  @override
  AdvisorState createState() => AdvisorState();
}

class AdvisorState extends State<Advisor> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
