import 'package:equatable/equatable.dart';
import 'package:nanoid/nanoid.dart';

import 'models.dart';

enum TaskStatus {
  planed,
  started,
  finished,
  canceled,
}

class Task extends Equatable {
  final String taskId;
  final Activity activity;
  final DateTime startTime;
  final Duration duration;
  final TaskStatus status;

  Task(
      {String taskId,
      this.activity,
      this.startTime,
      Duration duration,
      TaskStatus status})
      : status = status ??
            (DateTime.now().isBefore(startTime)
                ? TaskStatus.planed
                : TaskStatus.canceled),
        duration = duration ?? Duration(hours: 1),
        taskId = taskId ?? nanoid();

  Task copyWith(
      {String taskId,
      TaskStatus status,
      DateTime startTime,
      Duration duration}) {
    return Task(
      activity: this.activity,
      taskId: taskId ?? this.taskId,
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      taskId: json['taskId'] as String,
      activity: Activity.fromJson(json['activity']),
      startTime: DateTime.parse(json['startTime'] as String),
      duration: Duration(minutes: (json['duration'] as int)),
      status: TaskStatus.values[(json['status'] as int)]);

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'activity': activity.toJson(),
        'startTime': startTime.toIso8601String(),
        'duration': duration.inMinutes,
        'status': status.index
      };

  @override
  List<Object> get props => [taskId, activity, startTime, duration, status];

  @override
  bool get stringify => true;
}
