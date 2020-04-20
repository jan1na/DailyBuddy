part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ToggleDarkModeEvent extends PreferencesEvent {}

class LoadInitialPreferencesEvent extends PreferencesEvent {}
