part of 'days_bloc.dart';

abstract class DaysEvent extends Equatable {
  const DaysEvent();
}

class ChangeDayEvent extends DaysEvent {
  final DateTime day;
  const ChangeDayEvent({this.day});
  @override
  List<Object> get props => [day];
}
