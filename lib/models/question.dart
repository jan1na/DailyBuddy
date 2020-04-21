import 'package:equatable/equatable.dart';
import 'package:nanoid/nanoid.dart';

class Question extends Equatable {
  final String questionId;
  //final String questionText;
  final DateTime startTime;
  final bool hasAnswer;
  final bool isRelevant;

  Question(
      {String questionId,
      //this.questionText,
      this.startTime,
      this.hasAnswer,
      this.isRelevant})
      : questionId = questionId ?? nanoid();

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json['questionId'] as String,
        //questionText: json['questionText'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        hasAnswer: json['hasAnswer'] == '1' as bool,
        isRelevant: json['isRelevant'] == '1' as bool,
      );

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        //'questionText': questionText,
        'startTime': startTime.toIso8601String(),
        'hasAnswer': hasAnswer ? '1' : '0',
        'isRelevant': isRelevant ? '1' : '0',
      };

  @override
  List<Object> get props => [
        questionId,
        //questionText,
        startTime, hasAnswer, isRelevant
      ];

  @override
  bool get stringify => true;
}

class UiQuestion {
  final String questionId;
  DateTime startTime;
  bool hasAnswer;
  bool isRelevant;
  final String relevantText;
  final String questionText;

  UiQuestion(this.questionId,
      {this.startTime,
      this.hasAnswer,
      this.isRelevant,
      this.questionText,
      this.relevantText});
}

List<dynamic> Questions = [
  {
    'questionId': '1',
    'relevantText': 'Früstückst Du',
    'questionText': 'wann möchstest Du früstücken',
  },
  {
    'questionId': '2',
    'relevantText': 'isst Du zu Mittag',
    'questionText': 'wann möchstest Du Mittagessen',
  },
  {
    'questionId': '3',
    'relevantText': 'isst Du zu Abend',
    'questionText': 'wann möchstest Du Abendessen',
  },
  {
    'questionId': '4',
    'relevantText': 'möchtest du Sport machen',
    'questionText': 'wann möchstest Du Sport machen',
  },
];
