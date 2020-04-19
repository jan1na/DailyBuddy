import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  @override
  UserState get initialState => super.initialState ?? UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent user,
  ) async* {
    switch (user.runtimeType) {
      case ChangeUserEvent:
        yield* mapChangeUserEvent(user);
        break;
    }
  }

  Stream<UserState> mapChangeUserEvent(ChangeUserEvent user) async* {
    yield UserState(user: state.user);
  }

  @override
  UserState fromJson(Map<String, dynamic> json) {
    return UserState(user: User.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    return state.user.toJson();
  }
}
