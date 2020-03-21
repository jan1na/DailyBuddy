class User {
  static User theOne;

  static User the() {
    if (theOne == null) {
      theOne = new User();
    }
    return theOne;
  }

  DateTime from;
  DateTime to;
  List names;
  List todos;

  User() {
    names = [];
    todos = [];
  }
}
