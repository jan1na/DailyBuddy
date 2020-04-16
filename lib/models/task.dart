import 'package:DailyBuddy/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:nanoid/nanoid.dart';

class Task extends Equatable {
  final String taskId;
  final Activity activity;
  final DateTime startTime;
  final Duration duration;

  Task({String taskId, this.activity, this.startTime, Duration duration})
      : duration = duration ?? Duration(hours: 1),
        taskId = taskId ?? nanoid();

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json['taskId'] as String,
        activity: Activity.fromJson(json['activity']),
        startTime: DateTime.parse(json['startTime'] as String),
        duration: Duration(minutes: (json['duration'] as int)),
      );

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'activity': activity.toJson(),
        'startTime': startTime.toIso8601String(),
        'duration': duration.inMinutes
      };

  @override
  List<Object> get props => [taskId, activity, startTime, duration];

  @override
  bool get stringify => true;
}
