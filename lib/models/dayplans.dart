import 'package:DailyBuddy/models/dayplan.dart';

class Dayplans {
  Dayplans() {
    list = new List();
  }

  List<Dayplan> list;

  void add(Dayplan _dayplan) {
    list.add(_dayplan);
  }

  Dayplan findByID(String _id) {
    return list.singleWhere((_c) => _c.id == _id);
  }

  void setList(List<Dayplan> _list) {
    list = _list;
  }

  void clear() {
    list.clear();
  }

  get length => list.length;
}
