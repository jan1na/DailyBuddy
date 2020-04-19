import 'package:equatable/equatable.dart';
import 'package:nanoid/nanoid.dart';

class Question extends Equatable {
  final String questionId;
  final String questionText;
  final DateTime startTime;
  final bool hasAnswer;

  Question(
      {String questionId, this.questionText, this.startTime, this.hasAnswer})
      : questionId = questionId ?? nanoid();

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json['questionId'] as String,
        questionText: json['questionText'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        hasAnswer: json['hasAnswer'] == '1' as bool,
      );

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'questionText': questionText,
        'startTime': startTime.toIso8601String(),
        'hasAnswer': hasAnswer ? '1' : '0',
      };

  @override
  List<Object> get props => [questionId, questionText, startTime];

  @override
  bool get stringify => true;
}
