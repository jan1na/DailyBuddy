import 'package:flutter/material.dart';

class Names extends StatefulWidget {
  Names({Key key, this.title, this.screenChanged})
      : super(key: key);

  final String title;
  final ValueChanged<Widget> screenChanged;

  @override
  NamesState createState() => NamesState();
}

class NamesState extends State<Names> {
  List names;

  NamesState() {
    names = [];
  }

  void add() async {
    String name = null;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController();
        final field = new TextField(
          autofocus: true,
          decoration: new InputDecoration(
              labelText: 'Voller Name', hintText: 'z.B. Herman Toothrot'),
          controller: controller,
        );
        
        return new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                child: field,
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('OK'),
                onPressed: () {
                  name = controller.text;
                  Navigator.pop(context);
                })
          ],
        );
      },
    );

    if (name != null) {
      setState(() {
        names.add(name);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List containers = <Widget>[];
    for (String name in names) {
      containers.add(new Container(height: 50, color: Colors.amber[600], child: new Center(child: Text(name))));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: containers,
              ),
            ),
            RaisedButton(
              onPressed: () {
                widget.screenChanged(new Names(title: 'Namen', screenChanged: widget.screenChanged));
              },
              child: Text(
                'Weiter',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        tooltip: 'Neuer Name',
        child: Icon(Icons.add),
      ),
    );
  }
}
