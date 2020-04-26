import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nanoid/nanoid.dart';

import 'blocs.dart';
import '../models/models.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  final DaysBloc daysBloc;
  StreamSubscription daysBlocSubscription;

  TasksBloc({context}) : daysBloc = BlocProvider.of<DaysBloc>(context) {
    daysBlocSubscription =
        daysBloc.listen((daysState) => checkForOutdated(daysState));
  }

  void checkForOutdated(DaysState daysState) {
    final currentWeekStart = daysState.weekDays.first;
    if (state.taskList
        .any((task) => task.startTime.isBefore(currentWeekStart))) {
      add(RemoveTasksEvent(state.taskList
          .where((task) => task.startTime.isBefore(currentWeekStart))
          .map((task) => task.taskId)
          .toList()));
    }
  }

  @override
  TasksState get initialState =>
      super.initialState ?? TasksState(taskList: List.unmodifiable([]));

  @override
  Stream<TasksState> mapEventToState(
    TasksEvent event,
  ) async* {
    switch (event.runtimeType) {
      case AddTaskEvent:
        yield* mapAddTaskEvent(event);
        break;
      case RemoveTaskEvent:
        yield* mapRemoveTaskEvent(event);
        break;
      case RemoveTasksEvent:
        yield* mapRemoveTasksEvent(event);
        break;
      case SetTaskStatusEvent:
        yield* mapSetTaskStatusEvent(event);
        break;
      case ClearAllTasksEvent:
        yield* mapClearAllTasksEvent(event);
        break;
      case RescheduleTaskEvent:
        yield* mapRescheduleTaskEvent(event);
        break;
    }
  }

  Stream<TasksState> mapAddTaskEvent(AddTaskEvent event) async* {
    yield TasksState(
        taskList: List<Task>.unmodifiable([...state.taskList, event.task]));
  }

  Stream<TasksState> mapRemoveTaskEvent(RemoveTaskEvent event) async* {
    yield TasksState(
        taskList: List<Task>.unmodifiable(state.taskList
            .where((task) => task.taskId != event.taskId)
            .toList()));
  }

  Stream<TasksState> mapRemoveTasksEvent(RemoveTasksEvent event) async* {
    yield TasksState(
        taskList: List<Task>.unmodifiable(state.taskList
            .where((task) => !event.taskIdList.contains(task.taskId))
            .toList()));
  }

  Stream<TasksState> mapSetTaskStatusEvent(SetTaskStatusEvent event) async* {
    yield TasksState(
        taskList: List<Task>.unmodifiable(state.taskList
            .map((task) => task.taskId == event.taskId
                ? task.copyWith(status: event.taskStatus)
                : task)
            .toList()));
  }

  Stream<TasksState> mapClearAllTasksEvent(ClearAllTasksEvent event) async* {
    yield TasksState(taskList: List.unmodifiable([]));
  }

  Stream<TasksState> mapRescheduleTaskEvent(RescheduleTaskEvent event) async* {
    final newId = nanoid();
    yield TasksState(
        taskList: List<Task>.unmodifiable(state.taskList
            .map((task) => task.taskId == event.taskId
                ? task.copyWith(taskId: newId, startTime: event.startTime)
                : task)
            .toList()));
  }

  @override
  TasksState fromJson(Map<String, dynamic> json) => TasksState(
      taskList: List<Task>.unmodifiable((json['taskList'] as List)
          .map((task) => Task.fromJson(task))
          .toList()));

  @override
  Map<String, dynamic> toJson(TasksState state) =>
      {'taskList': state.taskList.map((e) => e.toJson()).toList()};

  @override
  Future<void> close() {
    daysBlocSubscription.cancel();
    return super.close();
  }
}
