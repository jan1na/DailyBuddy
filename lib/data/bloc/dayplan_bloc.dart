import 'package:DailyBuddy/models/dayplan.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_base.dart';

class DayplanBloc extends BlocBase {
  static final DayplanBloc _dayplanBlocSingleton = new DayplanBloc._internal();
  factory DayplanBloc() {
    return _dayplanBlocSingleton;
  }

  DayplanBloc._internal();

  Dayplan _dayplan = Dayplan.fromId("0");

  final _dayplan$ = BehaviorSubject<Dayplan>.seeded(Dayplan.fromId("0"));

  Dayplan get dayplan => _dayplan$.value;

  Stream<Dayplan> get dayplan$ => _dayplan$.stream;

  @override
  void dispose() {
    _dayplan$.distinct();
    super.dispose();
  }
}
