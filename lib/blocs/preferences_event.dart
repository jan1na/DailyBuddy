part of 'preferences_bloc.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class SetDarkModeEvent extends PreferencesEvent {
  final bool isDarkMode;
  const SetDarkModeEvent({this.isDarkMode});
  @override
  List<Object> get props => [isDarkMode];
}

class LoadInitialPreferencesEvent extends PreferencesEvent {}
