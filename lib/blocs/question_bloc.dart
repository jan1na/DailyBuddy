import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/models.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends HydratedBloc<QuestionEvent, QuestionState> {
  @override
  QuestionState get initialState => super.initialState ?? QuestionInitial();

  @override
  Stream<QuestionState> mapEventToState(
    QuestionEvent question,
  ) async* {
    switch (question.runtimeType) {
      case ChangeQuestionEvent:
        yield* mapChangeUserEvent(question);
        break;
    }
  }

  Stream<QuestionState> mapChangeUserEvent(
      ChangeQuestionEvent question) async* {
    yield QuestionState(question: state.question);
  }

  @override
  QuestionState fromJson(Map<String, dynamic> json) {
    return QuestionState(question: Question.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(QuestionState state) {
    return state.question.toJson();
  }
}
