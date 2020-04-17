import 'package:flutter/material.dart';

import 'screens.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Einstellungen'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calendar_view_day)),
              Tab(icon: Icon(Icons.settings_applications)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SettingsActivities(),
            SettingsPreferences(),
          ],
        ),
      ),
    );
  }
}
