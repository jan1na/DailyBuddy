import 'models.dart';

class User {
  final String name;
  final bool has_open_questions;

  User({this.name, this.has_open_questions});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        has_open_questions: json['has_open_questions'] = '1' as bool,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'has_open_questions': has_open_questions ? '0' : '1',
      };
}
