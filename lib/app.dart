import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'page.dart';
import 'themes.dart';

class DailyBuddyApp extends StatelessWidget {
  const DailyBuddyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PreferencesBloc>(context),
      builder: (context, PreferencesState preferencesState) {
        final bool isDarkMode = preferencesState.darkMode;
        return MaterialApp(
          locale: Locale('de', ''),
          title: 'DailyBuddy',
          theme: isDarkMode ? darkTheme : defaultTheme,
          home: DailyBuddyPage(),
        );
      },
    );
  }
}
