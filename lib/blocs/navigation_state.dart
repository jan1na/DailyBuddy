part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class NavigationInitial extends NavigationState {}

class NavigationToTaskDetail extends NavigationState {
  final taskId;
  const NavigationToTaskDetail({this.taskId});
  @override
  List<Object> get props => [taskId];
}
