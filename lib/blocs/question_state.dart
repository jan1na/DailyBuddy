part of 'question_bloc.dart';

class QuestionState extends Equatable {
  final Question question;

  QuestionState({this.question});

  @override
  List<Object> get props => [question];
  @override
  bool get stringify => true;
}

class QuestionInitial extends QuestionState {
  QuestionInitial() : super(question: Question());
}
