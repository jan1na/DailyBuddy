import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/models.dart';

part 'next_question_event.dart';
part 'next_question_state.dart';

class NextQuestionBloc
    extends HydratedBloc<NextQuestionEvent, NextQuestionState> {
  @override
  NextQuestionState get initialState =>
      super.initialState ?? NextQuestionInitial();

  @override
  Stream<NextQuestionState> mapEventToState(
    NextQuestionEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ChangeNextQuestionEvent:
        yield* mapNextQuestionEvent(event);
        break;
    }
  }

  Stream<NextQuestionState> mapNextQuestionEvent(NextQuestionEvent event) {}

  @override
  NextQuestionState fromJson(Map<String, dynamic> json) {
    return NextQuestionState(question: Question.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(NextQuestionState state) {
    return state.question.toJson();
  }
}
