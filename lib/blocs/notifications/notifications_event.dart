part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
  @override
  List<Object> get props => [];
  @override
  bool get stringify => true;
}

class AddTaskNotificationEvent extends NotificationsEvent {
  final Task task;
  const AddTaskNotificationEvent(this.task);
  @override
  List<Object> get props => [task];
}

class RemoveTaskNotificationEvent extends NotificationsEvent {
  final String taskId;
  const RemoveTaskNotificationEvent(this.taskId);
  @override
  List<Object> get props => [taskId];
}
