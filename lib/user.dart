class Entry {
  Entry(String title, bool done) {
    this.title = title;
    this.done = done;
  }

  String title;
  bool done;
  DateTime due;
}

class User {
  static User theOne;
  static List defaultDailyTasks = ['Smile', 'Frühstück', 'Skype-Lunch', 'Skype-Dinner', 'Log-Eintrag'];

  static User the() {
    if (theOne == null) {
      theOne = new User();
    }
    return theOne;
  }

  DateTime from;
  DateTime to;
  DateTime now;
  List names;
  Map todos;

  User() {
    names = [];
    todos = new Map();
    from = DateTime.now();
    to = from.add(new Duration(days: 14));
    now = DateTime.now();
    String t;
    for (t in defaultDailyTasks) {
      todos.addEntries(new MapEntry(now, new Entry(t, false)));
    }
  }
}
