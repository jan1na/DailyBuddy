part of 'next_question_bloc.dart';

abstract class NextQuestionEvent extends Equatable {
  const NextQuestionEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ChangeNextQuestionEvent extends NextQuestionEvent {
  final Question question;
  const ChangeNextQuestionEvent({this.question});
  @override
  List<Object> get props => [question];
}
