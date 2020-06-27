import 'package:flutter/material.dart';
import 'package:daily_buddy_app/themes.dart';
import 'priorities_item.dart';
import 'package:daily_buddy_app/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrioritiesPage extends StatefulWidget {
  @override
  _PrioritiesPageState createState() => _PrioritiesPageState();
}

class _PrioritiesPageState extends State<PrioritiesPage> {
  List<Widget> statementList = <Widget>[];
  List<GlobalKey<PriorityItemWidgetState>> keys =
      <GlobalKey<PriorityItemWidgetState>>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 40, left: 15, right: 15, bottom: 12),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '''Wähle die Aussagen aus,
  die auf Dich zutreffen.''',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
        ..._buildPriorityItems(),
        RaisedButton(
          color: defaultTheme.primaryColor,
          padding: EdgeInsets.all(15.0),
          onPressed: checkedAllPriorities,
          child: const Text('Fertig', style: TextStyle(fontSize: 16)),
        )
      ],
    ));
  }

  List<Widget> _buildPriorityItems() {
    // todo: die richtigen Aussagen müssen hier eingefügt werden
    for (var i = 0; i < 10; i++) {
      keys.add(new GlobalKey<PriorityItemWidgetState>());
      statementList.add(PriorityItemWidget(
          key: keys[i], statement: Text('Aussage ' + (i + 1).toString())));
    }
    return statementList;
  }

  void checkedAllPriorities() {
    // todo: es muss in der Datenbank gespeichert werden, welche Schwerpunkte ausgewählt wurden
    for (var i = 0; i < statementList.length; i++) {
      if (statementList[i] is PriorityItemWidget) {
        print("Aussage " +
            i.toString() +
            " ist " +
            keys[i].currentState.isChecked.toString());
      }
    }
    BlocProvider.of<PrioritiesBloc>(context)
        .add(SetPrioritiesAreSetEvent(prioritiesAreSet: true));
    Navigator.pop(context);
    BlocProvider.of<MessagesBloc>(context)
        .add(ShowInfoMessageEvent("Danke für Deine Auswahl!"));
  }
}
