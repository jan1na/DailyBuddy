part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class ChangeUserEvent extends UserEvent {
  final User user;
  const ChangeUserEvent({this.user});
  @override
  List<Object> get props => [user];
}
