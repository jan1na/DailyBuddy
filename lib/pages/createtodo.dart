import 'package:flutter/material.dart';
import 'hub.dart';
import '../user.dart';

class CreateTodo extends StatefulWidget {
  CreateTodo({Key key, this.screenChanged})
      : super(key: key);

  final ValueChanged<Widget> screenChanged;

  @override
  CreateTodoState createState() => CreateTodoState();
}

class CreateTodoState extends State<CreateTodo> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final field = new TextField(
      autofocus: true,
      decoration: new InputDecoration(
          labelText: 'Todo', hintText: 'z.B. Staubsaugen'),
      controller: controller,
    );

    return Scaffold(
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            field,
            Row(children: <Widget>[
              RaisedButton(
                onPressed: () {
                  var entry = new Entry(controller.text, false);
                  User.the().todos.add(entry);
                  widget.screenChanged(new Hub(screenChanged: widget.screenChanged));
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 20)
                ),
              ),
              RaisedButton(
                onPressed: () {
                  widget.screenChanged(new Hub(screenChanged: widget.screenChanged));
                },
                child: Text(
                  'Abbrechen',
                  style: TextStyle(fontSize: 20)
                ),
              ),
            ],)
          ],
        ),
       ),
    );
  }
}
