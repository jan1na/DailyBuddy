part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ChangeQuestionEvent extends QuestionEvent {
  final Question question;
  const ChangeQuestionEvent({this.question});
  @override
  List<Object> get props => [question];
}
