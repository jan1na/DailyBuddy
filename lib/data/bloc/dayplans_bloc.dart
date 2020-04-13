import 'package:DailyBuddy/data/database.dart';
import 'package:DailyBuddy/models/dayplans.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';

class DayplansBloc extends BlocBase {
  static final DayplansBloc _dayplanBlocSingleton =
      new DayplansBloc._internal();
  factory DayplansBloc() {
    return _dayplanBlocSingleton;
  }

  DayplansBloc._internal() {
    getDayplans();
  }

  final _dayplans$ = BehaviorSubject<Dayplans>.seeded(Dayplans());

  void getDayplans() async {
    Dayplans dayplans = await DatabaseProvider.dbProvider.getDayplans();
    _dayplans$.add(dayplans);
  }
}
