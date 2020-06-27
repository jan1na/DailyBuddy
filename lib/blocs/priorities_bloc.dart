import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'priorities_event.dart';
part 'priorities_state.dart';

class PrioritiesBloc extends HydratedBloc<PrioritiesEvent, PrioritiesState> {
  @override
  PrioritiesState get initialState => super.initialState ?? PrioritiesInitial();

  @override
  Stream<PrioritiesState> mapEventToState(PrioritiesEvent event) async* {
    switch (event.runtimeType) {
      case SetPrioritiesAreSetEvent:
        yield* mapTogglePrioritiesEvent(
            (event as SetPrioritiesAreSetEvent).prioritiesAreSet);
        break;
      case LoadInitialPrioritiesEvent:
        yield* mapLoadInitialPrioritiesEvent();
        break;
    }
  }

  Stream<PrioritiesState> mapTogglePrioritiesEvent(
      bool prioritiesAreSet) async* {
    yield PrioritiesState(prioritiesAreSet: prioritiesAreSet);
  }

  Stream<PrioritiesState> mapLoadInitialPrioritiesEvent() async* {
    yield PrioritiesInitial();
  }

  @override
  PrioritiesState fromJson(Map<String, dynamic> json) =>
      PrioritiesState(prioritiesAreSet: jsonDecode(json['prioritiesAreSet']));

  @override
  Map<String, dynamic> toJson(PrioritiesState state) =>
      {'prioritiesAreSet': state.prioritiesAreSet.toString()};
}
