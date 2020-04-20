import 'package:daily_buddy_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/blocs.dart';

class TaskDetails extends StatelessWidget {
  final String taskId;

  TaskDetails({Key key, @required this.taskId}) : super(key: key);

  final Map<TaskStatus, Widget> statusWidget = {
    TaskStatus.planed: Column(
      children: <Widget>[
        Icon(Icons.event),
        Text("Geplant"),
      ],
    ),
    TaskStatus.started: Column(
      children: <Widget>[
        Icon(Icons.date_range),
        Text("Läuft"),
      ],
    ),
    TaskStatus.finished: Column(
      children: <Widget>[
        Icon(Icons.event_available),
        Text("Geschafft"),
      ],
    ),
    TaskStatus.canceled: Column(
      children: <Widget>[
        Icon(Icons.event_busy),
        Text("Abgebrochen"),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DaysBloc, DaysState>(builder: (context, daysState) {
      final DateTime today = daysState.today;
      return BlocBuilder<TasksBloc, TasksState>(
        builder: (context, tasksState) {
          final task = tasksState.taskList
              .firstWhere((t) => t.taskId == taskId, orElse: () => null);
          final runningTask = tasksState.taskList.firstWhere(
              (t) => t.status == TaskStatus.started,
              orElse: () => null);
          Task taskBefore;
          Task taskAfter;
          bool isToday = false;
          bool isInTime = false;
          bool isNext = false;
          if (task != null) {
            final taskStart = Jiffy(task.startTime);
            final taskEnd = taskStart.add(duration: task.duration);
            final dayTaskList = tasksState.taskList
                .where((t) => taskStart.isSame(t.startTime, Units.DAY))
                .toList();
            dayTaskList.sort((a, b) => a.startTime.compareTo(b.startTime));
            final taskIndex = dayTaskList.indexOf(task);

            taskBefore = taskIndex == 0 ? null : dayTaskList[taskIndex - 1];
            taskAfter = taskIndex == dayTaskList.length - 1
                ? null
                : dayTaskList[taskIndex + 1];
            isToday = taskStart.isSame(today, Units.DAY);
            isInTime =
                DateTime.now().isAfter(taskStart.subtract(minutes: 15)) &&
                    DateTime.now().isBefore(taskEnd);
            isNext = taskIndex == 0 || taskBefore == runningTask;
          }
          return Scaffold(
              appBar: AppBar(
                title: Text("Aufgabe"),
              ),
              body: task == null
                  ? Container()
                  : Container(
                      child: ListView(children: <Widget>[
                      Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                  backgroundColor:
                                      task.activity.category.color),
                              title: Text(task.activity.activityName),
                              subtitle: Text(Jiffy(task.startTime).fromNow()),
                              trailing: statusWidget[task.status],
                            ),
                            Linkify(
                              onOpen: (link) async {
                                if (await canLaunch(link.url)) {
                                  await launch(link.url);
                                }
                              },
                              linkStyle: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              options: LinkifyOptions(humanize: true),
                              text: task.activity.description,
                            ),
                            task.status == TaskStatus.planed
                                ? ButtonBar(
                                    children: <Widget>[
                                      isToday
                                          ? FlatButton.icon(
                                              label: Text('Starten'),
                                              icon: Icon(Icons.timer),
                                              onPressed: !(isInTime || isNext)
                                                  ? null
                                                  : () {
                                                      runningTask == null
                                                          ? BlocProvider.of<
                                                                      TasksBloc>(
                                                                  context)
                                                              .add(SetTaskStatusEvent(
                                                                  taskId: task
                                                                      .taskId,
                                                                  taskStatus:
                                                                      TaskStatus
                                                                          .started))
                                                          : showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Laufende ${runningTask.activity.category.categoryName} Aufgabe'),
                                                                  content: Text(
                                                                      "Die aktuelle Aufgabe ${runningTask.activity.activityName} ab ${Jiffy(runningTask.startTime).Hm} Uhr"),
                                                                  actions: <
                                                                      Widget>[
                                                                    FlatButton
                                                                        .icon(
                                                                      label: Text(
                                                                          'Öffnen'),
                                                                      icon: Icon(
                                                                          Icons
                                                                              .open_in_new),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => TaskDetails(
                                                                                      taskId: runningTask.taskId,
                                                                                    )));
                                                                      },
                                                                    ),
                                                                    FlatButton
                                                                        .icon(
                                                                      label: Text(
                                                                          'Geschafft'),
                                                                      icon: Icon(
                                                                          Icons
                                                                              .done),
                                                                      onPressed:
                                                                          () {
                                                                        BlocProvider.of<TasksBloc>(context).add(SetTaskStatusEvent(
                                                                            taskId:
                                                                                runningTask.taskId,
                                                                            taskStatus: TaskStatus.finished));
                                                                        BlocProvider.of<TasksBloc>(context).add(SetTaskStatusEvent(
                                                                            taskId:
                                                                                task.taskId,
                                                                            taskStatus: TaskStatus.started));
                                                                        Navigator.of(context,
                                                                                rootNavigator: true)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                    FlatButton
                                                                        .icon(
                                                                      label: Text(
                                                                          'Nicht Geschafft'),
                                                                      icon: Icon(
                                                                          Icons
                                                                              .close),
                                                                      onPressed:
                                                                          () {
                                                                        BlocProvider.of<TasksBloc>(context).add(SetTaskStatusEvent(
                                                                            taskId:
                                                                                runningTask.taskId,
                                                                            taskStatus: TaskStatus.canceled));
                                                                        BlocProvider.of<TasksBloc>(context).add(SetTaskStatusEvent(
                                                                            taskId:
                                                                                task.taskId,
                                                                            taskStatus: TaskStatus.started));
                                                                        Navigator.of(context,
                                                                                rootNavigator: true)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              });
                                                    },
                                            )
                                          : Container(),
                                      FlatButton.icon(
                                        label: Text('Verschieben'),
                                        icon: Icon(Icons.update),
                                        onPressed: () {
                                          //TODO: implement DateTime Selection Dialog
                                          BlocProvider.of<TasksBloc>(context)
                                              .add(RescheduleTaskEvent(
                                                  taskId: task.taskId,
                                                  startTime: task.startTime.add(
                                                      Duration(minutes: 15))));
                                        },
                                      ),
                                      FlatButton.icon(
                                        label: Text('Löschen'),
                                        icon: Icon(Icons.alarm_off),
                                        onPressed: () {
                                          BlocProvider.of<TasksBloc>(context)
                                              .add(
                                                  RemoveTaskEvent(task.taskId));
                                          Navigator.of(context).pop(
                                              "${task.activity.activityName} gelöscht");
                                        },
                                      ),
                                    ],
                                  )
                                : task.status == TaskStatus.started
                                    ? ButtonBar(
                                        children: <Widget>[
                                          FlatButton.icon(
                                            label: Text('Erledigt'),
                                            icon: Icon(Icons.done),
                                            onPressed: () {
                                              BlocProvider.of<TasksBloc>(
                                                      context)
                                                  .add(SetTaskStatusEvent(
                                                      taskId: task.taskId,
                                                      taskStatus:
                                                          TaskStatus.finished));
                                            },
                                          ),
                                          FlatButton.icon(
                                            label: Text('Abbruch'),
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              BlocProvider.of<TasksBloc>(
                                                      context)
                                                  .add(SetTaskStatusEvent(
                                                      taskId: task.taskId,
                                                      taskStatus:
                                                          TaskStatus.canceled));
                                            },
                                          ),
                                        ],
                                      )
                                    : Container(),
                          ],
                        ),
                      ),
                      (taskBefore == null && taskAfter == null)
                          ? Container()
                          : Card(
                              child: ListTile(
                                leading: FlatButton.icon(
                                  label: Text(taskBefore == null
                                      ? ''
                                      : taskBefore.activity.activityName),
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: taskBefore == null
                                      ? null
                                      : () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TaskDetails(
                                                        taskId:
                                                            taskBefore.taskId,
                                                      )));
                                        },
                                ),
                                trailing: FlatButton.icon(
                                  label: Text(taskAfter == null
                                      ? ''
                                      : taskAfter.activity.activityName),
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: taskAfter == null
                                      ? null
                                      : () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TaskDetails(
                                                        taskId:
                                                            taskAfter.taskId,
                                                      )));
                                        },
                                ),
                              ),
                            )
                    ])));
        },
      );
    });
  }
}
