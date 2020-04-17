import 'package:flutter/material.dart';
import 'hub.dart';
import 'createtodo.dart';
import '../user.dart';

class CreateCustomTodo extends StatefulWidget {
  CreateCustomTodo({Key key, this.screenChanged}) : super(key: key);

  final ValueChanged<Widget> screenChanged;

  @override
  CreateCustomTodoState createState() => CreateCustomTodoState();
}

class CreateCustomTodoState extends State<CreateCustomTodo> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final field = new TextField(
      autofocus: true,
      decoration:
          new InputDecoration(labelText: 'Todo', hintText: 'z.B. Staubsaugen'),
      controller: controller,
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            field,
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    var entry = new Entry(controller.text, false);
                    entry.due = User.the().now;
                    User.the().todos.add(entry);
                    widget.screenChanged(
                        new Hub(screenChanged: widget.screenChanged));
                  },
                  child: Text('OK', style: TextStyle(fontSize: 20)),
                ),
                RaisedButton(
                  onPressed: () {
                    widget.screenChanged(
                        new CreateTodo(screenChanged: widget.screenChanged));
                  },
                  child: Text('Abbrechen', style: TextStyle(fontSize: 20)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
