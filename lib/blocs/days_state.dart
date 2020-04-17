part of 'days_bloc.dart';

class DaysState extends Equatable {
  final DateTime today;
  final List<DateTime> weekDays;
  DaysState({this.today, this.weekDays});

  @override
  List<Object> get props => [today, weekDays];

  @override
  bool get stringify => true;
}
