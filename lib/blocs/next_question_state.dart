part of 'next_question_bloc.dart';

class NextQuestionState extends Equatable {
  final Question question;

  NextQuestionState({this.question});

  @override
  List<Object> get props => ([question]);
}

class NextQuestionInitial extends NextQuestionState {
  NextQuestionInitial() : super(question: Question());
}
