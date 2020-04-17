part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class AddTaskEvent extends TasksEvent {
  final Task task;
  const AddTaskEvent(this.task);
  @override
  List<Object> get props => [task];
}

class RemoveTaskEvent extends TasksEvent {
  final String taskId;
  const RemoveTaskEvent(this.taskId);
  @override
  List<Object> get props => [taskId];
}

class RemoveTasksEvent extends TasksEvent {
  final List<String> taskIdList;
  const RemoveTasksEvent(this.taskIdList);
  @override
  List<Object> get props => [taskIdList];
}
