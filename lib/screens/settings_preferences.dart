import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class SettingsPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        BlocBuilder<PreferencesBloc, PreferencesState>(
            builder: (context, PreferencesState preferencesState) {
          final bool isDarkMode = preferencesState.darkMode;
          return Card(
              child: ListTile(
            title: Text(
              'Dark Mode',
            ),
            trailing: DayNightSwitcher(
              isDarkModeEnabled: isDarkMode,
              onStateChanged: (_) => BlocProvider.of<PreferencesBloc>(context)
                  .add(ToggleDarkModeEvent()),
            ),
          ));
        }),
      ],
    );
  }
}
