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
    tasksBlocSubscription =
        tasksBloc.listen((tasksState) => updateToTasksState(tasksState));
  }

  void updateToTasksState(TasksState tasksState) {
    tasksState.taskList
        .where((task) => !state.taskNotificationMap.keys.contains(task.taskId))
        .forEach((task) => add(AddTaskNotificationEvent(task)));
    state.taskNotificationMap.keys
        .where((taskId) =>
            !tasksState.taskList.map((task) => task.taskId).contains(taskId))
        .forEach((taskId) => add(RemoveTaskNotificationEvent(taskId)));
  }

  @override
  NotificationsState get initialState => NotificationsState(
      taskNotificationMap: Map<String, int>.unmodifiable({}));

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AddTaskNotificationEvent:
        yield* mapAddTaskNotificationEvent(
            event, Map.of(state.taskNotificationMap));
        break;
      case RemoveTaskNotificationEvent:
        yield* mapRemoveTaskNotificationEvent(
            event, Map.of(state.taskNotificationMap));
        break;
    }
  }

  Stream<NotificationsState> mapAddTaskNotificationEvent(
      AddTaskNotificationEvent event,
      Map<String, int> taskNotificationMap) async* {
    String generatedId = await generate('0123456789', 8);
    int notificationId = int.tryParse(generatedId);

    await localNotificationsPlugin.schedule(
        notificationId,
        "${event.task.activity.category.categoryName} Aufgabe",
        "${event.task.activity.activityName} ab ${Jiffy(event.task.startTime).Hm} Uhr",
        event.task.startTime,
        notificationDetails);

    taskNotificationMap[event.task.taskId] = notificationId;
    yield NotificationsState(
        taskNotificationMap:
            Map<String, int>.unmodifiable(taskNotificationMap));
  }

  Stream<NotificationsState> mapRemoveTaskNotificationEvent(
      RemoveTaskNotificationEvent event,
      Map<String, int> taskNotificationMap) async* {
    await localNotificationsPlugin.cancel(taskNotificationMap[event.taskId]);
    Map.of(taskNotificationMap).remove(event.taskId);
    yield NotificationsState(
        taskNotificationMap:
            Map<String, int>.unmodifiable(taskNotificationMap));
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
