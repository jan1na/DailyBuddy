import 'package:daily_buddy_app/advisor.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class SchedulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wochenplan'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Advisor()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
        body: SchedulesWeekView());
  }
}
