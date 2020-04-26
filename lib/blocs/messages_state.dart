part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

abstract class ShowMessage extends MessagesState {
  final String text;
  final DateTime time;
  ShowMessage(this.text) : time = DateTime.now();
  @override
  List<Object> get props => [text, time];
}

class MessagesInitial extends MessagesState {}

class ShowErrorMessage extends ShowMessage {
  ShowErrorMessage(String text) : super(text);
}

class ShowInfoMessage extends ShowMessage {
  ShowInfoMessage(String text) : super(text);
}
