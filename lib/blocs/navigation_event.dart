part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class OpenTaskDetailEvent extends NavigationEvent {
  final String taskId;
  const OpenTaskDetailEvent({this.taskId});
  @override
  List<Object> get props => [taskId];
}
