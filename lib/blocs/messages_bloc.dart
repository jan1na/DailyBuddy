import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  @override
  MessagesState get initialState => MessagesInitial();

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    switch (event.runtimeType) {
      case ShowErrorMessageEvent:
        yield ShowErrorMessage(event.text);
        break;
      case ShowInfoMessageEvent:
        yield ShowInfoMessage(event.text);
        break;
    }
  }
}
