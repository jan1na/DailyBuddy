part of 'preferences_bloc.dart';

class PreferencesState extends Equatable {
  final bool darkMode;
  const PreferencesState({this.darkMode});

  @override
  List<Object> get props => [darkMode];

  @override
  bool get stringify => true;
}

class PreferencesInitial extends PreferencesState {
  PreferencesInitial() : super(darkMode: false);
}
