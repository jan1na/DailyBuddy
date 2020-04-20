import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  StreamSubscription notificationSelectedSubscription;

  NavigationBloc({Stream notificationSelectedStream}) {
    notificationSelectedSubscription =
        notificationSelectedStream.listen((playload) {
      add(OpenTaskDetailEvent(taskId: playload));
    });
  }

  @override
  NavigationState get initialState => NavigationInitial();

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    switch (event.runtimeType) {
      case OpenTaskDetailEvent:
        yield NavigationToTaskDetail(
            taskId: (event as OpenTaskDetailEvent).taskId);
        break;
    }
  }

  @override
  Future<void> close() {
    notificationSelectedSubscription.cancel();
    return super.close();
  }
}
