import 'package:flutter/material.dart';
import 'todo.dart';
import 'createtodo.dart';
import 'help.dart';
import '../user.dart';

class Hub extends StatefulWidget {
  Hub({Key key, this.screenChanged})
      : super(key: key);

  final ValueChanged<Widget> screenChanged;

  @override
  HubState createState() => HubState();
}

class HubState extends State<Hub> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var weekday = 'Unbekannt';
    switch (now.weekday) {
      case 1: weekday = 'Montag'; break;
      case 2: weekday = 'Dienstag'; break;
      case 3: weekday = 'Mittwoch'; break;
      case 4: weekday = 'Donnerstag'; break;
      case 5: weekday = 'Freitag'; break;
      case 6: weekday = 'Samstag'; break;
      case 7: weekday = 'Sonntag'; break;
    }
    var day = now.day;
    var month = now.month;
    var year = now.year;

    List containers = <Widget>[];
    int index = 0;
    for (Entry todo in User.the().todos) {
      int currentIndex = index;
      containers.add(
        new GestureDetector(
          onTap: () {
            widget.screenChanged(new Todo(screenChanged: widget.screenChanged, entry: User.the().todos[currentIndex]));
          },
          child: new Container(
            height: 50,
            color: Colors.amber[600],
            child: new Row(children: <Widget>[
              Switch(value: User.the().todos[index].done, onChanged: (bool value) {
                widget.screenChanged(new Todo(screenChanged: widget.screenChanged, entry: User.the().todos[currentIndex]));
              },),
              Text(todo.title),
            ]
          ))
        )
      );
      ++index;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$weekday, der $day.$month.$year',
              style: Theme.of(context).textTheme.display1,
            ),
            SizedBox(
              height: 50,
              child:LinearProgressIndicator(value: 0.5,),
            ),
            new Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: containers,
              ),
            ),
            RaisedButton(
              onPressed: () {
                widget.screenChanged(new Help(screenChanged: widget.screenChanged));
              },
              child: Text(
                'Hilfe',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.screenChanged(new CreateTodo(screenChanged: widget.screenChanged));
        },
        tooltip: 'Neues Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
