import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends HydratedBloc<PreferencesEvent, PreferencesState> {
  @override
  PreferencesState get initialState =>
      super.initialState ?? PreferencesInitial();

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    switch (event.runtimeType) {
      case SetDarkModeEvent:
        yield* mapToggleDarkModeEvent((event as SetDarkModeEvent).isDarkMode);
        break;
      case LoadInitialPreferencesEvent:
        yield* mapLoadInitialPreferencesEvent();
        break;
    }
  }

  Stream<PreferencesState> mapToggleDarkModeEvent(bool isDarkMode) async* {
    yield PreferencesState(darkMode: isDarkMode);
  }

  Stream<PreferencesState> mapLoadInitialPreferencesEvent() async* {
    yield PreferencesInitial();
  }

  @override
  PreferencesState fromJson(Map<String, dynamic> json) =>
      PreferencesState(darkMode: jsonDecode(json['darkMode']));

  @override
  Map<String, dynamic> toJson(PreferencesState state) =>
      {'darkMode': state.darkMode.toString()};
}
