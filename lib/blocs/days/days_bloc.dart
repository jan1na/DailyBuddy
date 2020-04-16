import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';

part 'days_event.dart';
part 'days_state.dart';

class DaysBloc extends Bloc<DaysEvent, DaysState> {
  StreamSubscription checkDaySubscription;

  DaysBloc() {
    checkDaySubscription = Stream.periodic(Duration(minutes: 15)).listen((_) {
      if (getDay(DateTime.now()).isAfter(state.today)) {
        add(ChangeDayEvent(day: DateTime.now()));
      }
    });
  }

  @override
  DaysState get initialState => DaysState(
      today: getDay(DateTime.now()), weekDays: getWeekDays(DateTime.now()));

  @override
  Stream<DaysState> mapEventToState(
    DaysEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ChangeDayEvent:
        yield* mapChangeDayEvent(event);
        break;
    }
  }

  DateTime getDay(DateTime date) => Jiffy(date).startOf(Units.DAY);
  List<DateTime> getWeekDays(DateTime date) => List<DateTime>.generate(
      7,
      (int index) =>
          Jiffy(date).startOf(Units.WEEK).add(Duration(days: index)));

  Stream<DaysState> mapChangeDayEvent(ChangeDayEvent event) async* {
    final today = getDay(event.day);
    yield DaysState(
        today: today,
        weekDays: today.isAfter(state.weekDays.last)
            ? getWeekDays(event.day)
            : state.weekDays);
  }

  @override
  Future<void> close() {
    checkDaySubscription.cancel();
    return super.close();
  }
}
