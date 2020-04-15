import 'package:intl/intl.dart';

class Dayplan {
  String id;
  DateTime date;
  String activity;
  bool is_done;
  String picture;

  Dayplan(this.id, this.date, this.activity, this.is_done, this.picture);

  Dayplan copyWith({
    String id,
    DateTime date,
    String activity,
    bool is_done,
    String picture,
  }) {
    return Dayplan(id ?? this.id, date ?? this.date, activity ?? this.activity,
        is_done ?? this.is_done, picture ?? this.picture);
  }

  factory Dayplan.fromJson(Map<String, dynamic> json) => new Dayplan(
        json["id"].toString(),
        DateTime.parse(json["date"]),
        json["activity"],
        json["is_done"] == '1',
        json["picture"],
      );

  Map<String, dynamic> toJson() => {
        id == '0' ? "id" : id: null,
        "date": DateFormat('yyyy-MM-dd HH:mm:ss').format(date),
        "activity": activity,
        "is_done": is_done ? 1 : 0,
        "picture": picture,
      };

  String toString() {
    var selDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    return 'Dayplan{id: $id, date: $selDate, activity: $activity, isDone: $is_done, picture: $picture}';
  }

  static fromId(String _id) {
    return Dayplan(_id, null, "", false, "");
  }
}
