part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final Map<String, int> taskNotificationMap;
  const NotificationsState({this.taskNotificationMap});
  @override
  List<Object> get props => [taskNotificationMap];
  @override
  bool get stringify => true;
}
