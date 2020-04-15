import 'package:DailyBuddy/data/database.dart';
import 'package:DailyBuddy/models/dayplan.dart';
import 'package:DailyBuddy/models/dayplans.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';

class DayplansBloc extends BlocBase {
  static final DayplansBloc _dayplanBlocSingleton =
      new DayplansBloc._internal();

  factory DayplansBloc(DateTime _date) {
    _dayplanBlocSingleton.date = _date;
    return _dayplanBlocSingleton;
  }

  DayplansBloc._internal() {
    date = DateTime.now();
    getDayplans();
  }

  DateTime date;

  final _dayplans$ = BehaviorSubject<Dayplans>.seeded(Dayplans());

  void add(Dayplan plan) {
    Dayplans dayplans = _dayplans$.value;
    dayplans.add(plan);
    _dayplans$.add(dayplans);
  }

  void setDate(DateTime _date) async {
    date = _date;
    getDayplans();
  }

  void getDayplans() async {
    //List<Dayplan> dayplans = await DatabaseProvider.dbProvider.getDayplans();
    Dayplans dayplans = await DatabaseProvider.dbProvider.getDayplans(date);
    //Dayplans dayplans = await DatabaseProvider.dbProvider.getAllDayplans();
    _dayplans$.add(dayplans);
  }

  get dayplans => _dayplans$.stream;
}
