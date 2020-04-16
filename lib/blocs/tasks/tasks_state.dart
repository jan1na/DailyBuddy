part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> taskList;
  const TasksState({this.taskList});
  @override
  List<Object> get props => [taskList];
  @override
  bool get stringify => true;
}
