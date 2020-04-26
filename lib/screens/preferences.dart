import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class PreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
        builder: (context, PreferencesState preferencesState) {
      final bool isDarkMode = preferencesState.darkMode;
      return ListView(
        children: <Widget>[
          Card(
              child: ListTile(
            title: Text(
              'Dark Mode',
            ),
            trailing: DayNightSwitcher(
              isDarkModeEnabled: isDarkMode,
              onStateChanged: (_) => BlocProvider.of<PreferencesBloc>(context)
                  .add(ToggleDarkModeEvent()),
            ),
          )),
        ],
      );
    });
  }
}
