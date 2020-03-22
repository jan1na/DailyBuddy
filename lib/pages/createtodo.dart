import 'package:flutter/material.dart';
import 'hub.dart';
import 'createcustomtodo.dart';
import '../user.dart';

class Category {
  String name;
  List<String> sub;

  Category(this.name, this.sub);
}

class CreateTodo extends StatefulWidget {
  CreateTodo({Key key, this.screenChanged})
      : categories = [
        new Category('Haushalt', ['Fenster putzen', 'Wäsche waschen', 'Zimmer aufräumen']),
        new Category('Wellness', ['Kopf kratzen', 'Nase popeln', 'Schlafen']),
        new Category('Kommunikation', ['Mama anrufen', 'Kinder anschreien', 'Selbstgespräch führen']),
        new Category('Basteln', ['Ikea', 'Lego', 'Duplo']),
      ],
      super(key: key);

  final ValueChanged<Widget> screenChanged;
  final List<Category> categories;

  @override
  CreateTodoState createState() => CreateTodoState();
}

class CreateTodoState extends State<CreateTodo> {
  int categoryIndex = -1;

  @override
  Widget build(BuildContext context) {
    var categoryButtons = new List<RaisedButton>();
    categoryButtons.add(new RaisedButton(
      onPressed: () {
        widget.screenChanged(new CreateCustomTodo(screenChanged: widget.screenChanged));
      },
      color: Colors.orange,
      child: Text('Selbst definieren', style: TextStyle(fontSize: 20)),));

    var index = 0;
    for (var category in widget.categories) {
      var currentIndex = index;
      categoryButtons.add(new RaisedButton(
        onPressed: () {
          setState(() {
            categoryIndex = currentIndex;
          });
        },
        color: Colors.orange,
        child: Text(category.name, style: TextStyle(fontSize: 20)),
      ));

      if (index == categoryIndex) {
        for (var sub in category.sub) {
          categoryButtons.add(new RaisedButton(
            onPressed: () {
              var entry = new Entry(sub, false);
              User.the().todos.add(entry);
              widget.screenChanged(new Hub(screenChanged: widget.screenChanged));
            },
            color: Colors.yellow,
            child: Text(sub, style: TextStyle(fontSize: 20)),
          ));
        }
      }

      ++index;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Neue Aufgabe'),
      ),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: categoryButtons,
      ),
      ),
    );
  }
}
