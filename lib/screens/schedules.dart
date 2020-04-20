import 'package:daily_buddy_app/advisor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import 'screens.dart';

class SchedulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wochenplan'),
          actions: <Widget>[
            IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.cached),
              onPressed: () {
                BlocProvider.of<NotificationsBloc>(context)
                    .add(ClearAllNotificationsEvent());
                BlocProvider.of<TasksBloc>(context).add(ClearAllTasksEvent());
                BlocProvider.of<PreferencesBloc>(context)
                    .add(LoadInitialPreferencesEvent());
              },
            ),
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
