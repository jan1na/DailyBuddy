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

class SetTaskStatusEvent extends TasksEvent {
  final String taskId;
  final TaskStatus taskStatus;
  const SetTaskStatusEvent({this.taskId, this.taskStatus});
  @override
  List<Object> get props => [taskId, taskStatus];
}

class ClearAllTasksEvent extends TasksEvent {
  const ClearAllTasksEvent();
  @override
  List<Object> get props => [];
}

class RescheduleTaskEvent extends TasksEvent {
  final String taskId;
  final DateTime startTime;
  const RescheduleTaskEvent({this.taskId, this.startTime});
  @override
  List<Object> get props => [taskId, startTime];
}
