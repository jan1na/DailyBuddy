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
      case ToggleDarkModeEvent:
        yield* mapToggleDarkModeEvent();
        break;
    }
  }

  Stream<PreferencesState> mapToggleDarkModeEvent() async* {
    yield PreferencesState(darkMode: !state.darkMode);
  }

  @override
  PreferencesState fromJson(Map<String, dynamic> json) =>
      PreferencesState(darkMode: jsonDecode(json['darkMode']));

  @override
  Map<String, dynamic> toJson(PreferencesState state) =>
      {'darkMode': state.darkMode.toString()};
}
