import 'package:DailyBuddy/data/database.dart';
import 'package:DailyBuddy/models/dayplan.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';

class DayplanBloc extends BlocBase {
  static final DayplanBloc _dayplanBlocSingleton = new DayplanBloc._internal();
  factory DayplanBloc(String id) {
    _dayplanBlocSingleton._dayplan.id = id;
    return _dayplanBlocSingleton;
  }

  DayplanBloc._internal() {
    readDayplan(_dayplan.id);
  }

  Dayplan _dayplan = Dayplan.fromId("0");

  final _dayplan$ = BehaviorSubject<Dayplan>.seeded(Dayplan.fromId("0"));

  Dayplan get dayplan => _dayplan$.value;

  Stream<Dayplan> get dayplan$ => _dayplan$.stream;

  void setDate(DateTime date) {
    _dayplan.date = date;
    _dayplan$.value.date = date;
    _dayplan$.add(_dayplan);
  }

  void updatDayplan(Dayplan plan) {
    _dayplan = plan;
    _dayplan$.add(_dayplan);
  }

  saveDayplan(Dayplan plan) async {
    if (plan.id == '0') {
      await DatabaseProvider.dbProvider.newDayplan(plan);
    } else {
      await DatabaseProvider.dbProvider.updateDayplan(plan);
    }
    _dayplan = plan;
    _dayplan$.add(_dayplan);
  }

  void readDayplan(String id) async {
    Dayplan dbDayplan;
    if (id != '0') {
      dbDayplan = await DatabaseProvider.dbProvider.getDayplan(id);
      if (dbDayplan != null) {
        _dayplan = dbDayplan;
        _dayplan$.add(dbDayplan);
      }
    }
  }

  @override
  void dispose() {
    _dayplan$.distinct();
    super.dispose();
  }
}
