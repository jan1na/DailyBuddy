import 'package:daily_buddy_app/themes.dart';
import 'package:daily_buddy_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text(getCurrentDate()),
        ),
        body: Center(
            child:
            Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                createMainMenuItems(context)
            )
        )
    );
  }

  List<Widget> createMainMenuItems(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    List<Widget> mainMenuItems = [];

    //Willkommens-Zeile
    Container welcome = Container(
        width: widthScreen / 1.2,
        padding: EdgeInsets.only(top: 60.0),
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

    return mainMenuItems;
  }

  String getCurrentDate(){
    return DateFormat('dd.MM.yy').format(DateTime.now());
  }
}
