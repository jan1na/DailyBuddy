part of 'user_bloc.dart';

class UserState extends Equatable {
  final User user;

  UserState({this.user});

  @override
  List<Object> get props => [user];
  @override
  bool get stringify => true;
}

class UserInitial extends UserState {
  UserInitial() : super(user: User(has_open_questions: true));
}
