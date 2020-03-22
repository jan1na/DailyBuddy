import 'package:flutter/material.dart';
import 'user.dart';

class Todo extends StatefulWidget {
  Todo({Key key, this.title, this.screenChanged})
      : super(key: key);

  final String title;
  final ValueChanged<Widget> screenChanged;

  @override
  TodoState createState() => TodoState();
}

class TodoState extends State<Todo> {
  TodoState();

  void add() async {
    String todo;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController();
        final field = new TextField(
          autofocus: true,
          decoration: new InputDecoration(
              labelText: 'Todo', hintText: 'z.B. Staubsaugen'),
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
                  todo = controller.text;
                  Navigator.pop(context);
                })
          ],
        );
      },
    );

    if (todo != null) {
      setState(() {
        User.the().todos.add(new Entry(todo, false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List containers = <Widget>[];
    int index = 0;
    for (Entry todo in User.the().todos) {
      int currentIndex = index;
      containers.add(new Container(height: 50, color: Colors.amber[600], child: new Row(children: <Widget>[
        Switch(value: User.the().todos[index].done, onChanged: (bool value) {
          setState(() {
            User.the().todos[currentIndex].done = !User.the().todos[currentIndex].done;
          });
        },),
        Text(todo.title),
      ])));
      ++index;
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
                // TODO
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
        tooltip: 'Neues Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
