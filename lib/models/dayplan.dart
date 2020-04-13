class Dayplan {
  String id;
  DateTime date;
  String activity;
  bool isDone;
  String picture;

  Dayplan(this.id, this.date, this.activity, this.isDone, this.picture);

  Dayplan copyWith({
    String id,
    DateTime date,
    String activity,
    bool isDone,
    String picture,
  }) {
    return Dayplan(id ?? this.id, date ?? this.date, activity ?? this.activity,
        isDone ?? this.isDone, picture ?? this.picture);
  }

  factory Dayplan.fromJson(Map<String, dynamic> json) => new Dayplan(
        json["id"],
        json["date"],
        json["activity"],
        json["isDone"],
        json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "activity": activity,
        "isDone": isDone,
        "picture": picture,
      };

  String toString() {
    return 'Dayplan{id: $id, date: $date, activity: $activity, isDone: $isDone, picture: $picture}';
  }

  static fromId(String _id) {
    return Dayplan(_id, null, "", false, "");
  }
}
