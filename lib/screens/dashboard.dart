import 'package:daily_buddy_app/screens/priorities_selection/priorites.dart';
import 'package:daily_buddy_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:daily_buddy_app/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrioritiesBloc, PrioritiesState>(
        builder: (context, PrioritiesState prioritiesState) {
          return Scaffold(
              appBar: AppBar(centerTitle: true,
                title: Text(getCurrentDate()),
              ),
              body: Center(
                  child:
                  Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      createMainMenuItems(context, prioritiesState.prioritiesAreSet)
                  )
              )
          );
        });
  }

  List<Widget> createMainMenuItems(BuildContext context, bool prioritiesAreSet) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    List<Widget> mainMenuItems = [];

    //Willkommens-Zeile
    Container welcome = Container(
        width: widthScreen / 1.2,
        padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
        child: FittedBox(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.wb_sunny,
                      color: defaultTheme.accentColor),
                  Text('  Schön, dass du da bist!  '),
                  Icon(Icons.wb_sunny,
                      color: defaultTheme.accentColor)
                ]
            )
        )
    );


    mainMenuItems.add(welcome);

    if(!prioritiesAreSet){
      RaisedButton prioritiesButton = RaisedButton(
        color: defaultTheme.primaryColor,
        padding: EdgeInsets.all(15.0),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PrioritiesPage())),
        child: const Text('Schwerpunkte festlegen', style: TextStyle(fontSize: 20)),
      );

      mainMenuItems.add(prioritiesButton);
    }

    return mainMenuItems;
  }

  String getCurrentDate(){
    return DateFormat('dd.MM.yy').format(DateTime.now());
  }
}
