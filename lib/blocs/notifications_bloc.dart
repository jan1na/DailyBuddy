import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nanoid/async/generate.dart';

import 'blocs.dart';
import '../models/models.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc
    extends HydratedBloc<NotificationsEvent, NotificationsState> {
  final NotificationDetails notificationDetails = NotificationDetails(
      AndroidNotificationDetails(
          "daily_buddy_app", "DailyBuddy", "DailyBuddy Aufgaben"),
      IOSNotificationDetails());
  final FlutterLocalNotificationsPlugin localNotificationsPlugin;
  final TasksBloc tasksBloc;
  StreamSubscription tasksBlocSubscription;

  NotificationsBloc({this.localNotificationsPlugin, BuildContext context})
      : tasksBloc = BlocProvider.of<TasksBloc>(context) {
    tasksBlocSubscription = tasksBloc.listen((tasksState) {
      updateToTasksState(tasksState.taskList
          .where((t) => t.status == TaskStatus.planed)
          .toList());
    });
  }

  void updateToTasksState(List<Task> planedTaskList) {
    planedTaskList
        .where((task) => !state.taskNotificationMap.keys.contains(task.taskId))
        .forEach((task) => add(AddTaskNotificationEvent(task)));
    state.taskNotificationMap.keys
        .where((taskId) =>
            !planedTaskList.map((task) => task.taskId).contains(taskId))
        .forEach((taskId) => add(RemoveTaskNotificationEvent(taskId)));
  }

  @override
  NotificationsState get initialState =>
      super.initialState ??
      NotificationsState(
          taskNotificationMap: Map<String, int>.unmodifiable({}));

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AddTaskNotificationEvent:
        yield* mapAddTaskNotificationEvent(event);
        break;
      case RemoveTaskNotificationEvent:
        yield* mapRemoveTaskNotificationEvent(event);
        break;
      case ClearAllNotificationsEvent:
        yield* mapClearAllNotificationsEvent(event);
        break;
    }
  }

  Stream<NotificationsState> mapAddTaskNotificationEvent(
      AddTaskNotificationEvent event) async* {
    final generatedId = await generate('0123456789', 8);
    final notificationId = int.tryParse(generatedId);
    final taskNotificationMap = Map.of(state.taskNotificationMap);

    await localNotificationsPlugin.schedule(
        notificationId,
        "${event.task.activity.category.categoryName} Aufgabe",
        "${event.task.activity.activityName} ab ${Jiffy(event.task.startTime).Hm} Uhr",
        event.task.startTime,
        notificationDetails,
        payload: event.task.taskId);

    taskNotificationMap[event.task.taskId] = notificationId;
    yield NotificationsState(
        taskNotificationMap:
            Map<String, int>.unmodifiable(taskNotificationMap));
  }

  Stream<NotificationsState> mapRemoveTaskNotificationEvent(
      RemoveTaskNotificationEvent event) async* {
    final taskNotificationMap = Map.of(state.taskNotificationMap);
    final notificationId = taskNotificationMap[event.taskId];
    if (notificationId != null) {
      await localNotificationsPlugin.cancel(notificationId);
    }
    taskNotificationMap.remove(event.taskId);
    yield NotificationsState(
        taskNotificationMap:
            Map<String, int>.unmodifiable(taskNotificationMap));
  }

  Stream<NotificationsState> mapClearAllNotificationsEvent(
      ClearAllNotificationsEvent event) async* {
    await localNotificationsPlugin.cancelAll();
    yield NotificationsState(
        taskNotificationMap: Map<String, int>.unmodifiable({}));
  }

  @override
  NotificationsState fromJson(Map<String, dynamic> json) => NotificationsState(
        taskNotificationMap: Map<String, int>.unmodifiable(
            (jsonDecode(json['taskNotificationMap']) as Map<String, int>)),
      );

  @override
  Map<String, dynamic> toJson(NotificationsState state) => {
        'taskNotificationMap': jsonEncode(state.taskNotificationMap),
      };

  @override
  Future<void> close() {
    tasksBlocSubscription.cancel();
    return super.close();
  }
}
