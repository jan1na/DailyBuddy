part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  final String text;
  const MessagesEvent(this.text);
  @override
  List<Object> get props => [text];
  @override
  bool get stringify => true;
}

class ShowErrorMessageEvent extends MessagesEvent {
  ShowErrorMessageEvent(String text) : super(text);
}

class ShowInfoMessageEvent extends MessagesEvent {
  ShowInfoMessageEvent(String text) : super(text);
}